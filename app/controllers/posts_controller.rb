class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

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
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to root_path
    end
  end

  def update
    @post = Post.find(params[:id])
     if @post.update(post_params)
      redirect_to post_path
     else
      render :edit
     end
  end
  

  def post_params
    params.require(:post).permit(:subject, :title, :text, :image).merge(user_id: current_user.id)
  end
end
