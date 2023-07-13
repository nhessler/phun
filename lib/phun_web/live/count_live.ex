defmodule PhunWeb.CountLive do
  use PhunWeb, :live_view

  alias Phun.Counter
  
  def render(assigns) do
    ~H"""
    <h1 class="text-4xl">Count <%= Counter.show(@count) %></h1>
    <button
      phx-click="inc"
      class="rounded-lg bg-zinc-900 hover:bg-zinc-700
      py-2 px-3 text-sm font-semibold leading-6
      text-white active:text-white/80">Inc</button>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, Counter.new())}
  end

  def handle_event("inc", _meta, socket) do
    {:noreply, assign(socket, :count, Counter.inc(socket.assigns.count))}
  end
end
