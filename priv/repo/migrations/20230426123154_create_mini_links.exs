defmodule UrlShortener.Repo.Migrations.CreateMiniLinks do
  use Ecto.Migration

  def change do
    create table(:mini_links) do
      add :key, :string
      add :url, :string

      timestamps()
    end
  end
end
