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
  end

  def post_params
    params.require(:post).permit(:subject, :title, :text, :image).merge(user_id: current_user.id)
  end
end
