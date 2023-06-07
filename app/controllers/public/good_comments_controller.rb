class Public::GoodCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @post_comment = PostComment.find(params[:post_comment_id])
    good_comment = current_user.good_comments.new(post_comment_id: @post_comment.id)
    good_comment.save
    @post_comment.create_notification_by(current_user, @post_comment.id, @post_comment.user_id)
  end

  def destroy
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @post_comment = PostComment.find(params[:post_comment_id])
    good_comment = current_user.good_comments.find_by(post_comment_id: @post_comment.id)
    good_comment.destroy
  end

end