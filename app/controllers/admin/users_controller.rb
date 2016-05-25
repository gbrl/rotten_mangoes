class Admin::UsersController < Admin::ApplicationController

  def index
    if check_admin
    @users = User.order(:firstname).page params[:page]
    else
      redirect_to movies_path
    end
  end

  def show
    if check_admin
      @user = User.find(params[:id])
    else
      redirect_to movies_path
    end
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
    if check_admin
      admin_id = current_user.id
      @user = User.find(params[:id])
      session.clear
      session[:admin_id] = admin_id
      session[:user_id] = @user.id
      redirect_to admin_user_path(params[:id])
    else
      redirect_to movies_path
    end
  end

  def unpossess
    admin_id = session[:admin_id]
    session.clear
    session[:user_id] = admin_id
    redirect_to admin_user_path(params[:id])
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end


