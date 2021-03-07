defmodule Dilong.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add(:title, :string)
      add(:description, :text)
      add(:file_url, :string)
      add(:copied_markdown, :text, null: true)
      add(:published, :boolean, default: false)
      add(:published_on, :date, null: true)
      add(:last_updated, :date, null: true)

      timestamps()
    end
  end
end
