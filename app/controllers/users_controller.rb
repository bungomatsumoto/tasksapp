class UsersController < ApplicationController
skip_before_action :must_login, only: [:new, :create]

  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: "ユーザー'#{@user.name}'を登録しました"
    else
      render :new
    end
  end

  def show
    if current_user == User.find(params[:id])
      @user = User.find(params[:id])
    else
      redirect_to tasks_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
