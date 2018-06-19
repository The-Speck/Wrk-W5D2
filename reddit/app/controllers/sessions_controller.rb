class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    username = user_params[:username]
    password = user_params[:password]
    @user = User.find_by_credentials(username, password)
    
    if @user
      login(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["Invalid Username/Password"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
