class Public::UsersController < ApplicationController

  def show
     @user = User.find(params[:id])
     @counseling_posts = @user.counseling_posts
     @good_comments_count = @user.total_good_comments_count
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
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会手続きが完了しました。ご利用ありがとうございました。"
    redirect_to root_path
  end

  # ユーザーが参考になった相談に登録した相談投稿の一覧を取得します。
  def counseling_post_favorites
    @counseling_posts = current_user.counseling_post_favoirtes.includes(:user).order(created_at: :desc)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted)
  end


end
