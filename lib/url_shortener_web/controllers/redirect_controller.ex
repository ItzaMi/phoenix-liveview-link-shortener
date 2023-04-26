defmodule UrlShortenerWeb.RedirectController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Links

  def index(conn, %{"key" => key}) do
    link = Links.get_by_key(key)

    case link do
      nil ->
        conn
        |> put_flash(:error, "Link not found")
        |> redirect(to: "/")

      _ ->
        conn
        |> redirect(external: link.url)
    end
  end
end
