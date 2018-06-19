class PostsController < ApplicationController
  before_action :ensure_author, only: [:update, :edit]
  before_action :require_login, except: [:show]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.sub_id = params[:sub_id]
    
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:sub_id])
  end
  
  def update
    @post = Post.find(params[:sub_id])
    
    if @post.update(post_params)
      redirect_to posts_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def show
    @post = Post.find(:params[:id])
  end
  
  def ensure_author
    redirect_to subs_url unless current_user.id == Post.find(params[:id]).user_id
  end
  
  def post_params
    params.require(:post).permit(:title, :description)
  end
end
