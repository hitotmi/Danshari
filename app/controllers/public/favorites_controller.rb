class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    favorite = current_user.favorites.new(counseling_post_id: @counseling_post.id)
    favorite.save
    @counseling_post.create_notification_by(current_user, @counseling_post.id, @counseling_post.user_id)
  end

  def destroy
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    favorite = current_user.favorites.find_by(counseling_post_id: @counseling_post.id)
    favorite.destroy
  end

end
