defmodule UrlShortener.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mini_links" do
    field :key, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:key, :url])
    |> validate_required([:key, :url])
  end
end
