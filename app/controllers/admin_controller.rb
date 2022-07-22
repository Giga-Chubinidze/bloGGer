class AdminController < ApplicationController
  def index
  end

  def posts
    @posts = Post.all.includes(:user, :comments)
  end

  def comments
    @comments = Comment.all.includes(:user, :post)
  end

  def users
    @users = User.all.includes(:posts, :comments)
  end

  def show_post
    @post = Post.includes(:user, :comments).find(params[:id])
  end

  def destroy_post
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post was successfully deleted!"
    redirect_to admin_posts_path
  end

  def destroy_comment
    @comments = Comment.all.includes(:user, :post)
    @comment = @comments.find(params[:id])
    @comment.destroy 
    flash[:notice] = "Comment was successfully deleted!"
    redirect_to admin_comments_path
  end

  def destroy_user
    @users = User.all.includes(:posts, :comments)
    @user = @users.find(params[:id])
    @user.destroy 
    flash[:notice] = "User was successfully deleted!"
    redirect_to admin_users_path
  end

  def approve_post 
    @post = Post.find(params[:id])
    @post.update(approval_status: true)
    mail = UserMailer.approve_post(@post.user_id)
    mail.deliver_now
    flash[:notice] = "Post was successfully approved!"
    redirect_to admin_posts_path
  end
end
