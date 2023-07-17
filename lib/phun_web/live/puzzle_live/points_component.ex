defmodule PhunWeb.PuzzleLive.PointsComponent do
  use PhunWeb, :live_component

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


  defp change_cell(socket, x, y) do
    x = String.to_integer(x)
    y = String.to_integer(y)

    grid = socket.assigns.grid
    new_grid = Map.put(grid, {x, y}, !grid[{x, y}])
    
    assign(socket, :grid, new_grid)
  end


  defp assign_grid(socket, puzzle) do
    grid =
    for x <- 1..puzzle.width, y <- 1..puzzle.height, into: %{} do
      {{x, y}, false}
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

  defp rect_class(alive), do: "#{color(alive)} #{hover_color(alive)}"

  defp hover_color(true), do: "hover:fill-slate-600"
  defp hover_color(false), do: "hover:fill-slate-300"
end