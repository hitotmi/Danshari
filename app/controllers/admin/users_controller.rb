class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(15)
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

  def counseling_posts_index
    @user = User.find(params[:user_id])
    @counseling_posts = @user.counseling_posts.order(created_at: :desc).page(params[:page]).per(9)
  end

  def post_comments_index
    @user = User.find(params[:user_id])
    @post_comments = @user.post_comments.order(created_at: :desc).page(params[:page]).per(15)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :is_deleted, :admin)
  end

end
