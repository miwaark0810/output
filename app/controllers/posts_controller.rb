class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
     if @post.save
       redirect_to root_path
     else
       render :new
     end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
    unless @post.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
     if @post.update(post_params)
      redirect_to post_path
     else
      render :edit
     end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  private
  
  def post_params
    params.require(:post).permit(:subject, :title, :text, :image).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
