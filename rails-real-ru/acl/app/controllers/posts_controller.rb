# frozen_string_literal: true

class PostsController < ApplicationController
  after_action :verify_authorized, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  # BEGIN
  def index
    @posts = Post.order(created_at: :desc)
  end

  def show; end

  def new
    authorize Post
    @post = current_user.posts.build
  end

  def create
    @post = Post.new(post_params.merge(author: current_user))
    authorize @post
    if @post.save
      redirect_to @post, notice: 'Post was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully destroyed'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
  # END
end
