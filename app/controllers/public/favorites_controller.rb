class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counseling_post, only: [:create, :destroy]

  def create
    favorite = current_user.favorites.new(counseling_post_id: @counseling_post.id)
    favorite.save
    # 参考リスト登録されたことを、投稿者に通知を作成する
    @counseling_post.create_notification_by(current_user, @counseling_post.id, @counseling_post.user_id)
  end

  def destroy
    favorite = current_user.favorites.find_by(counseling_post_id: @counseling_post.id)
    favorite.destroy
  end

  private

  def set_counseling_post
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
  end
end
