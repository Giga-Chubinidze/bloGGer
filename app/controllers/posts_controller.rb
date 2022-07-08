class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :is_owner, only: [:edit, :destroy]

  decorates_assigned :posts, :post

  def index
    @posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 4)
  end

  def show
    @comments = @post.comments.paginate(page: params[:page]||1,per_page: 3)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post was successfully created!"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated!"
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post was successfully deleted!"
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def is_owner
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to @post
    end
  end
end
