class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報を編集しました。"
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :is_deleted, :admin)
  end

end
