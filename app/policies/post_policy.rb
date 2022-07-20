class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if @user != nil && (@user.has_any_role? :admin)
        scope.all
      else
        # scope.where(vip: true)
        scope.where(approval_status: true)
      end
    end
  end

  def initialize(user, post)
    @user, @post = user, post
  end

  def index? 
    true 
  end

  def update?
    valid_permissioned_user
  end

  def edit?
    valid_permissioned_user
  end

  def destroy?
    valid_permissioned_user
  end

  private 
    def valid_permissioned_user
      (@user.has_role? :admin)|| @post.user_id == @user.id
    end
end
