class Public::UsersController < ApplicationController

  def show
     @user = User.find(params[:id])
     @counseling_posts = @user.counseling_posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def withdraw_confirm
  end

  def withdraw
  end

  def counseling_post_favorites
    @counseling_posts = current_user.counseling_post_favoirtes.includes(:user).order(created_at: :desc)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted)
  end


end
