# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def initialize(current_user, user)
    super
    raise Pundit::NotAuthorizedError, 'must be logged in' unless current_user

    @current_user = current_user
    @user = user
  end

  def update?
    @current_user.admin? || same_user?
  end

  def destroy?
    @current_user.admin? || same_user?
  end

  private

  def same_user?
    @current_user.id == @user.id
  end
end
