defmodule Dilong.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :description, :text
      add :file_url, :string
      add :copied_markdown, :text
      add :published, :boolean, default: false, null: false
      add :published_on, :utc_datetime
      add :last_updated, :utc_datetime

      timestamps()
    end

  end
end
