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
      <div class="px-6 pt-4 pb-2">
        <.count_button click="inc" myself={@myself}>Inc</.count_button>
        <.count_button click="dec" myself={@myself}>Dec</.count_button>
      </div>
    </div>
    """
  end

  attr :myself, :string
  attr :click, :string
  slot :inner_block
  
  def count_button(assigns) do
    ~H"""
    <span
      class="inline-block bg-gray-200 rounded-full px-3 py-1 text-sm font-semibold
             text-gray-700 mr-2 mb-2"
      phx-click={@click}
      phx-target={@myself}
    >
      <%= render_slot(@inner_block) %>
    </span>
    """
  end

  def handle_event("inc", _meta, socket) do
    {:noreply, assign(socket, :count, Counter.inc(socket.assigns.count))}
  end

  def handle_event("dec", _meta, socket) do
    {:noreply, assign(socket, :count, Counter.dec(socket.assigns.count))}
  end
end
