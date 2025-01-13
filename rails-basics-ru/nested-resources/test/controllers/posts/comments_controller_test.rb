# frozen_string_literal: true

require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = post_comments(:one)
  end

  test 'should create post_comment' do
    assert_difference('PostComment.count') do
      post post_comments_url(@comment.post), params: { post_comment: { body: @comment.body } }
    end

    assert_redirected_to post_url(@comment.post)
  end

  test 'should get edit' do
    get edit_post_comment_url(@comment.post, @comment)
    assert_response :success
  end

  test 'should update post_comment' do
    patch post_comment_url(@comment.post, @comment),
          params: { post_comment: { body: @comment.body } }
    assert_redirected_to post_url(@comment.post)
  end

  test 'should destroy post_comment' do
    assert_difference('PostComment.count', -1) do
      delete post_comment_url(@comment.post, @comment)
    end

    assert_redirected_to post_url(@comment.post)
  end
end
