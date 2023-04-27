defmodule UrlShortenerWeb.PageLive do
  use UrlShortenerWeb, :live_view

  alias UrlShortener.Links

  def mount(_params, _session, socket) do
    socket = assign(socket, mini_url: "")
    {:ok, socket}
  end

  def handle_event("submit", %{"url" => url}, socket) do
    Links.get_by_url(url)
    |> case do
      nil ->
        key =
          :crypto.strong_rand_bytes(10)
          |> Base.encode16()

        Links.create_link(%{url: url, key: key})

        socket = assign(socket, mini_url: UrlShortenerWeb.Endpoint.url() <> "/#{key}")
        {:noreply, socket}

      link ->
        socket = assign(socket, mini_url: UrlShortenerWeb.Endpoint.url() <> "/#{link.key}")
        {:noreply, socket}
    end
  end
end
