defmodule PhunWeb.CountLive do
  use PhunWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl">Count <%= @count %></h1>
    <button
      phx-click="inc"
      class="rounded-lg bg-zinc-900 hover:bg-zinc-700
      py-2 px-3 text-sm font-semibold leading-6
      text-white active:text-white/80">Inc</button>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("inc", _meta, socket) do
    {:noreply, assign(socket, :count, socket.assigns.count + 1)}
  end
end
