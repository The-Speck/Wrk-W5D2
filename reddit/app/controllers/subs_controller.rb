class SubsController < ApplicationController
  
  before_action :ensure_moderator, only: [:update, :edit]
  before_action :require_login, except: [:show, :index]
  
  def new
    @sub = Sub.new
  end
  
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
  end
  
  def update
    @sub = Sub.find(params[:id])
    
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def show
    @sub = Sub.find(:params[:id])
  end
  
  def index
    @subs = Sub.all
  end
  
  def ensure_moderator
    redirect_to subs_url unless current_user.id == Sub.find(params[:id]).moderator_id
  end
  
  def sub_params
    params.require(:sub).permit(:title, :url, :content)
  end
end
