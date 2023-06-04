class Public::FavoritesController < ApplicationController

  def create
    counseling_post = CounselingPost.find(params[:counseling_post_id])
    favorite = current_user.favorites.new(counseling_post_id: counseling_post.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    counseling_post = CounselingPost.find(params[:counseling_post_id])
    favorite = current_user.favorites.find_by(counseling_post_id: counseling_post.id)
    favorite.destroy
    redirect_to request.referer
  end

end
