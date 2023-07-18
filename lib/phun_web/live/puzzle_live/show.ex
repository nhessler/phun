defmodule PhunWeb.PuzzleLive.Show do
  use PhunWeb, :live_view

  alias Phun.Game

  @impl true
  def mount(_params, _session, socket) do
    Game.subscibe_puzzle_changed()
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> update_puzzle_points(id)}
  end

  defp update_puzzle_points(socket, id) do
    assign(socket, :puzzle, Game.get_puzzle!(id))
  end
     
  defp page_title(:show), do: "Show Puzzle"
  defp page_title(:edit), do: "Edit Puzzle"
  defp page_title(:points), do: "Edit Points"

  @impl true
  def handle_info({:points_changed, puzzle_id}, %{assigns: %{puzzle: %{id: puzzle_id}}}=socket) do
    {:noreply, update_puzzle_points(socket, puzzle_id)}
  end

  def handle_info({:points_changed, _puzzle_id}, socket), do: {:noreply, socket}     
end
