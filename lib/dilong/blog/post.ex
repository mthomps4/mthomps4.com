defmodule Dilong.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field(:title, :string)
    field(:description, :string)
    field(:file_url, :string)
    field(:copied_markdown, :string, default: "")
    field(:published, :boolean, default: false)
    field(:published_on, :date)
    field(:last_updated, :date)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [
      :title,
      :description,
      :file_url,
      :copied_markdown,
      :published,
      :published_on,
      :last_updated
    ])
    |> validate_required([
      :title,
      :description,
      :file_url
    ])
  end
end
