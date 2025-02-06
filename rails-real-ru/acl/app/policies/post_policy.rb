# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    user&.admin? || user&.id == record.author.id
  end

  def update?
    edit?
  end

  def destroy?
    user&.admin?
  end
  # END
end
