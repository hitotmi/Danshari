class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
     @user = User.find(params[:id])
     @counseling_posts = @user.counseling_posts.page(params[:page]).per(9)
     @good_comments_count = @user.total_good_comments_count
     # 1位のユーザーを取得
     @ranking_top_user = User.all.sort_by { |user| -user.total_count }.first
     # 1位ユーザーのトータルカウントを取得
     @top_count = @ranking_top_user.total_count
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新しました。"
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

  def ranking
    if user_signed_in? && current_user.name == 'ゲストユーザー'
      @users = User.all
    else
      @users = User.where.not(name: 'ゲストユーザー')
    end

    @users = @users.all.sort_by { |user| - user.total_count }
  end


  # ユーザーが参考になった相談に登録した相談投稿の一覧を取得します。
  def counseling_post_favorites
    @counseling_posts = current_user.counseling_post_favoirtes.includes(:user).order(created_at: :desc).page(params[:page]).per(9)
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "ゲストユーザー"
      redirect_to user_path(current_user)
      flash[:notice] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end


end
