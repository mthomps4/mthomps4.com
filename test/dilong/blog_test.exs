defmodule Dilong.BlogTest do
  use Dilong.DataCase

  alias Dilong.Blog

  describe "posts" do
    alias Dilong.Blog.Post

    @valid_attrs %{copied_markdown: "some copied_markdown", description: "some description", file_url: "some file_url", last_updated: "2010-04-17T14:00:00Z", published: true, published_on: "2010-04-17T14:00:00Z", title: "some title"}
    @update_attrs %{copied_markdown: "some updated copied_markdown", description: "some updated description", file_url: "some updated file_url", last_updated: "2011-05-18T15:01:01Z", published: false, published_on: "2011-05-18T15:01:01Z", title: "some updated title"}
    @invalid_attrs %{copied_markdown: nil, description: nil, file_url: nil, last_updated: nil, published: nil, published_on: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.copied_markdown == "some copied_markdown"
      assert post.description == "some description"
      assert post.file_url == "some file_url"
      assert post.last_updated == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert post.published == true
      assert post.published_on == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blog.update_post(post, @update_attrs)
      assert post.copied_markdown == "some updated copied_markdown"
      assert post.description == "some updated description"
      assert post.file_url == "some updated file_url"
      assert post.last_updated == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert post.published == false
      assert post.published_on == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
