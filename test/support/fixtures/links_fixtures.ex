defmodule UrlShortener.LinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShortener.Links` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        key: "some key",
        mini_link: "some mini_link",
        url: "some url"
      })
      |> UrlShortener.Links.create_link()

    link
  end
end
