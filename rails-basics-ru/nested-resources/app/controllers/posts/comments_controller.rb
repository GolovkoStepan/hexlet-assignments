# frozen_string_literal: true

class Posts::CommentsController < Posts::ApplicationController
  before_action :set_post_comment, only: %i[edit update destroy]

  def edit; end

  def create
    @comment = resource_post.post_comments.build(post_comment_params)

    if @comment.save
      redirect_to resource_post, notice: 'Post comment was successfully created.'
    else
      redirect_to resource_post
    end
  end

  def update
    if @comment.update(post_comment_params)
      redirect_to resource_post, notice: 'Post comment was successfully updated.'
    else
      redirect_to resource_post
    end
  end

  def destroy
    @comment.destroy!

    redirect_to resource_post, status: :see_other, notice: 'Post comment was successfully destroyed.'
  end

  private

  def set_post_comment
    @comment = PostComment.find(params[:id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end
end
