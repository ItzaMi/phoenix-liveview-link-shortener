defmodule UrlShortenerWeb.LinkLive.Index do
  use UrlShortenerWeb, :live_view

  alias UrlShortener.Links
  alias UrlShortener.Links.Link

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :mini_links, Links.list_mini_links())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Link")
    |> assign(:link, Links.get_link!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Link")
    |> assign(:link, %Link{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Mini links")
    |> assign(:link, nil)
  end

  @impl true
  def handle_info({UrlShortenerWeb.LinkLive.FormComponent, {:saved, link}}, socket) do
    {:noreply, stream_insert(socket, :mini_links, link)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    link = Links.get_link!(id)
    {:ok, _} = Links.delete_link(link)

    {:noreply, stream_delete(socket, :mini_links, link)}
  end
end
