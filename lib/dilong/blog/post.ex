defmodule Dilong.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :copied_markdown, :string
    field :description, :string
    field :file_url, :string
    field :last_updated, :utc_datetime
    field :published, :boolean, default: false
    field :published_on, :utc_datetime
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :file_url, :copied_markdown, :published, :published_on, :last_updated])
    |> validate_required([:title, :description, :file_url, :copied_markdown, :published, :published_on, :last_updated])
  end
end
