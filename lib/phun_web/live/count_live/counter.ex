defmodule PhunWeb.CountLive.Counter do
  # if you generated an app with mix phx.new --live
  # the line below would be: use MyAppWeb, :live_component
  use Phoenix.LiveComponent
  alias Phun.Counter

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(count: Counter.new())}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-sm rounded overflow-hidden shadow-lg">
      <div class="px-6 py-4">
        <div class="font-bold text-xl mb-2">Table <%= @table_number %></div>
        <p class="text-2xl">Score <%= Counter.show(@count) %></p>
      </div>
      <div class="flex p-2">
        <.count_button click="inc" myself={@myself} countby={ 1} side={"l"}>Inc</.count_button>
        <.count_button click="inc" myself={@myself} countby={-1} side={"r"}>Dec</.count_button>
      </div>
    </div>
    """
  end


  attr :myself, :any
  attr :countby, :integer, default: 1
  attr :click, :string
  attr :side, :string
  slot :inner_block
  
  def count_button(assigns) do
    ~H"""
    <button class="flex-1 bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 m-1 rounded"
            phx-click={@click}
	    phx-target={@myself}
	    phx-value-countby={@countby}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  def handle_event("inc", %{"countby" => count_by}, socket) do
    by = String.to_integer(count_by)
    {:noreply, assign(socket, :count, Counter.inc(socket.assigns.count, by))}
  end
end
