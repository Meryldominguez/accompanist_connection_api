# frozen_string_literal: true

class ConfirmationPolicy < ApplicationPolicy
  class Scope < Scope; end

  def initialize(user, record)
    super
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user

    @user = user
    @record = record
  end

  def confirm?
    @user.admin? || same_user?
  end

  def resend?
    @user.admin? || same_user?
  end

  private

  def same_user?
    @user.id == @record.id
  end
end
