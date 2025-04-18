# frozen_string_literal: true

class Api::V2::UsersController < Api::ApplicationController
  # BEGIN
  def index
    users = User.includes(:posts)
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end
  # END
end
