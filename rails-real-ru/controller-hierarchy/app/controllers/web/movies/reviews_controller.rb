# frozen_string_literal: true

module Web::Movies
  class ReviewsController < ApplicationController
    def index
      @reviews = resource_movie.reviews.order(created_at: :desc)
    end

    def new
      @review = resource_movie.reviews.build
    end

    def edit
      @review = resource_movie.reviews.find(params[:id])
    end

    def create
      @review = resource_movie.reviews.build(review_params)
      if @review.save
        redirect_to movie_reviews_path(resource_movie), notice: 'Create success'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @review = resource_movie.reviews.find(params[:id])
      if @review.update(review_params)
        redirect_to movie_reviews_path(resource_movie), notice: 'Update success'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @review = resource_movie.reviews.find(params[:id])
      @review.destroy
      redirect_to movie_reviews_path(resource_movie), notice: 'Review destroyed'
    end

    private

    def review_params
      params.require(:review).permit(:body, :movie)
    end
  end
end
