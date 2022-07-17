class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.has_role? :admin
  end

  def edit?
    update?
  end

  def update?
    false
  end
end
