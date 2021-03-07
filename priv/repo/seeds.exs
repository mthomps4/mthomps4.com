# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Dilong.Repo.insert!(%Dilong.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Dilong.Blog

IO.inspect(File.cwd!())

File.stream!("./meta.csv")
|> CSV.decode!(headers: true, strip_fields: true)
|> Enum.each(fn post ->
  %{body: md} = HTTPoison.get!(post.file_url)

  Blog.create_post(%{
    title: post["title"],
    description: post["description"],
    published: true,
    published_on: Date.from_iso8601!(post["published_on"]),
    last_updated: Date.from_iso8601!(post["published_on"]),
    file_url: post["raw_url"],
    copied_markdown: md
  })
  |> IO.inspect()
end)
