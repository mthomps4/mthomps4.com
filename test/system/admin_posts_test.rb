require "application_system_test_case"

class AdminPostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test "visiting the index" do
    visit admin_posts_url
    assert_selector "h1", text: "Posts"
  end

  test "should create post" do
    visit admin_posts_url
    click_on "New post"

    fill_in "Content", with: @post.content
    fill_in "Description", with: @post.description
    fill_in "Title", with: @post.title
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "should update Post" do
    visit admin_post_url(@post)
    click_on "Edit this post", match: :first

    fill_in "Content", with: @post.content
    fill_in "Description", with: @post.description
    fill_in "Title", with: @post.title
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end
end
