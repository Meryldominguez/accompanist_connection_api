# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope; end

  def initialize(user, record)
    super
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user

    @user = user
    @record = record
  end

  def update?
    @user.admin? || same_user?
  end

  def destroy?
    @user.admin? || same_user?
  end

  private

  def same_user?
    @user.id == @record.id
  end
end
