class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :is_owner, only: [:edit, :destroy]
  before_action :authorize_post, only: %i[edit update destroy]

  decorates_assigned :posts, :post

  def index
    @posts = @query.result.all.order("created_at DESC").paginate(page: params[:page], per_page: 2)
    authorize @posts
  end

  def show
    @comments = @post.comments.order("created_at DESC").paginate(page: params[:page]||1,per_page: 3)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      current_user.add_role(:post_creator)
      @post.add_role(:vip_post) if post_params[:is_vip]
      redirect_to @post, notice: "Post was successfully created!"
    else
      redirect_to root_path, notice: "Could not be created!"
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
      params.require(:post).permit(:title, :body, :user, :is_vip)
    end

    def find_post
      @post =  Post.find(params[:id])
    end

    def is_owner
      unless current_user == @post.user || current_user.has_role?(:admin)
        flash[:alert] = "That post doesn't belong to you!"
        redirect_to @post
      end
    end

    def authorize_post 
      authorize @post
    end
end
