class Admin::UsersController < Admin::ApplicationController

  before_filter :check_admin, :except => [:unpossess] 

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
    UserMailer.goodbye_email(@user).deliver_now
    @user.destroy
    redirect_to admin_users_path
  end


  def possess
    admin_id = current_user.id
    @user = User.find(params[:id])
    session[:admin_id] = admin_id
    session[:user_id] = @user.id
    redirect_to admin_user_path(params[:id])
  end


  def unpossess
    admin_id = session[:admin_id]
    session[:user_id] = admin_id
    redirect_to admin_user_path(params[:id])
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end


