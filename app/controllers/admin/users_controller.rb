class Admin::UsersController < Admin::ApplicationController

  def index
    @users = User.order(:firstname).page params[:page]
  end

  def show
   @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end


  def possess
    @user = User.find(params[:id])
    session.clear
    session[:user_id] = @user.id
    redirect_to admin_user_path(params[:id])
  end


    protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end


