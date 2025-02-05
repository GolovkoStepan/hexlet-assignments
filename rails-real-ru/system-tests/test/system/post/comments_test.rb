# frozen_string_literal: true

require 'application_system_test_case'

class Post::CommentsTest < ApplicationSystemTestCase
  def setup
    @post = posts(:one)
    @comment = @post.comments.create(body: 'Comment Body')
  end

  test 'creating a comment' do
    visit post_url(@post)

    fill_in 'post_comment_body', with: 'My Comment'

    assert_difference('Post::Comment.count') do
      click_button('Create Comment')
      assert_selector('.alert.alert-info', text: 'Comment was successfully created.')
      assert_current_path post_path(@post)
    end
    comment = Post::Comment.last
    assert_text(comment.body)
    assert_text(I18n.l(comment.created_at, format: :short))
    assert_link('Edit', href: edit_post_comment_path(@post, comment))
    assert_link('Delete', href: post_comment_path(@post, comment))
  end

  test 'updating a comment' do
    visit edit_post_comment_url(@post, @comment)

    fill_in 'Body', with: 'Some Gibberish'

    click_button('Update Comment')

    assert_selector('.alert.alert-info', text: 'Comment was successfully updated.')
    assert_current_path post_path(@post)
    @comment.reload
    assert_equal(@comment.body, 'Some Gibberish')
  end

  test 'deleting a comment' do
    visit post_url(@post)
    assert_text('Comment Body')

    assert_difference('Post::Comment.count', -1) do
      accept_confirm 'Are you sure?' do
        find_link('Delete', href: post_comment_path(@post, @comment)).click
      end
      assert_selector('.alert.alert-info', text: 'Comment was successfully destroyed.')
      assert_current_path post_path(@post)
      refute_text('Comment Body')
    end
  end
end
