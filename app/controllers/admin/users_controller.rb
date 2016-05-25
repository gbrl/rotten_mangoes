class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.order(:firstname).page params[:page]
  end

  def show
   current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params)
      redirect_to movie_path(@user)
    else
      render :edit
    end
  end

end


