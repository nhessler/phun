defmodule PhunWeb.PuzzleLive.PointsComponent do
  use PhunWeb, :live_component

  alias Phun.Game
  
  @impl true
  def update(%{puzzle: puzzle} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_grid(puzzle)}
  end

  @impl true
  def handle_event("toggle", %{"x" => x, "y" => y}, socket) do
    {:noreply, change_cell(socket, x, y)}
  end

  def handle_event("toggle", _meta, socket) do
    {:noreply, toggle(socket)}
  end

  def handle_event("save", _meta, socket) do
    {:noreply, save(socket)}
  end

  defp toggle(socket) do
    toggled_grid =
      socket.assigns.grid
      |> Enum.into(%{}, fn {point, bool} -> {point, !bool} end)
    
    assign(socket, :grid, toggled_grid)
  end
    

  defp save(socket) do
    puzzle = socket.assigns.puzzle
    points =
      socket.assigns.grid
      |> Enum.filter(fn {point, alive} -> alive end)
      |> Enum.map(fn {point, _alive} -> point end)

    Game.save_puzzle_points(puzzle, points)

    socket
    |> put_flash(:info, "Puzzle Points saved successfully")
    |> push_patch(to: socket.assigns.patch)
  end
  
  defp change_cell(socket, x, y) do
    x = String.to_integer(x)
    y = String.to_integer(y)

    grid = socket.assigns.grid
    new_grid = Map.put(grid, {x, y}, !grid[{x, y}])
    
    assign(socket, :grid, new_grid)
  end


  defp assign_grid(socket, puzzle) do
    points = Enum.map(puzzle.points, &{&1.x, &1.y})
    grid =
    for x <- 1..puzzle.width, y <- 1..puzzle.height, into: %{} do
      {{x, y}, {x, y} in points}
    end

    assign(socket, :grid, grid)
  end

  attr :myself, :any, required: true
  attr :x, :integer, required: true
  attr :y, :integer, required: true
  attr :alive, :boolean, default: false
  def rect(assigns) do
    ~H"""
    <rect
      class={rect_class(@alive)}
      phx-click="toggle"
      phx-value-x={@x}
      phx-value-y={@y}
      phx-target={@myself}
      x={@x*10}
      y={@y*10}
      width="10"
      height="10"
      rx="2" />
    """
  end

  defp color(true), do: "fill-black"
  defp color(false), do: "fill-white"

  defp rect_class(alive), do: "#{color(alive)} hover:opacity-60"
end
