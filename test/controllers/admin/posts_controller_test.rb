# frozen_string_literal: true

require 'test_helper'

class AdminPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
  end

  test 'should get index' do
    get admin_posts_url
    assert_response :success
  end

  test 'should create draft' do
    get new_admin_post_url
    post = Post.last
    assert post.title == 'DRAFT'
    assert_redirected_to edit_admin_post_url(post)
  end

  test 'should show post' do
    get admin_post_url(@post)
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    patch admin_post_url(@post),
          params: { post: { content: 'updated content', description: @post.description, title: @post.title,
                            published: @post.published, post_type: @post.post_type, featured_image: @post.featured_image } }
    assert_redirected_to admin_post_url(@post)
  end

  test 'should destroy post' do
    assert_difference('Post.count', -1) do
      delete admin_post_url(@post)
    end

    assert_redirected_to admin_posts_url
  end
end
