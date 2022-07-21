class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  class Scope < Scope
    def resolve
      if @user.nil? || @user.has_role?(:member) 
        scope.where(approval_status: true).or(scope.where(user: @user)).and(scope.where(is_vip: false))
      elsif @user.has_role? :admin
        scope.all
      elsif @user.has_role? :vip 
        scope.where(approval_status: true).or(scope.where(user: @user))
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
