class Admin::UsersController < ApplicationController
  skip_before_action :must_login
  before_action :if_not_admin

  def index
    @users = User.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "ユーザー<#{@user.name}>を登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "更新しました"
    elsif User.where(admin: 'true').count == 0
      flash.now[:alert] = "管理者不在にはできません"
      render :edit
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if  @user.destroy
      redirect_to admin_users_path, notice: "ユーザー<#{@user.name}>を削除しました"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def if_not_admin
    rescue403 unless current_user.admin?
    # raise Forbidden unless current_user.admin?
  end
end
