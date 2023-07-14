defmodule PhunWeb.FollowLive do
  use PhunWeb, :live_view

  def mount(_params, _session, socket) do
    Process.sleep(300)
    {:ok,
     socket
    |> follow({:mount, connected?(socket)})}
  end
 
  def render(assigns) do
    ~H"""
    <h1>Hello, World!</h1>
    <pre>
    <%= @follows |> Enum.reverse |> inspect %>
    </pre>

    <.link href={~p"/follow"}>http</.link>
    <.link patch={~p"/follow"}>Patch</.link>
    <.link navigate={~p"/follow"}>Navigate</.link>
    
    """
  end

  defp follow(socket, data) do
    follows = Map.get(socket.assigns, :follows) || []
    assign(socket, follows: [data | follows])
  end

  def handle_params(_params, _url, socket) do
    {:noreply, follow(socket, {:handle_params, connected?(socket)})}
  end
end
