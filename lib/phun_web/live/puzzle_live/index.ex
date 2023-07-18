defmodule PhunWeb.PuzzleLive.Index do
  use PhunWeb, :live_view

  alias Phun.Game
  alias Phun.Game.Puzzle

  @impl true
  def mount(_params, _session, socket) do
    Game.subscribe_puzzle_changed()
    {:ok, stream(socket, :puzzles, Game.list_puzzles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Puzzle")
    |> update_puzzle_points(id)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Puzzle")
    |> assign(:puzzle, %Puzzle{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Puzzles")
    |> assign(:puzzle, nil)
  end

  defp apply_action(socket, :points, %{"id" => id}) do
    socket
    |> assign(:puzzle, Game.get_puzzle!(id))
  end


  defp update_puzzle_points(socket, id) do
    assign(socket, :puzzle, Game.get_puzzle!(id))
  end
  
  @impl true
  def handle_info({PhunWeb.PuzzleLive.FormComponent, {:saved, puzzle}}, socket) do
    {:noreply, stream_insert(socket, :puzzles, puzzle)}
  end

  def handle_info({:points_changed, puzzle_id}, %{assigns: %{puzzle: %{id: puzzle_id}}}=socket) do
    {:noreply, update_puzzle_points(socket, puzzle_id)}
  end

  def handle_info({:points_changed, _puzzle_id}, socket), do: {:noreply, socket}
  
  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    puzzle = Game.get_puzzle!(id)
    {:ok, _} = Game.delete_puzzle(puzzle)

    {:noreply, stream_delete(socket, :puzzles, puzzle)}
  end
end
