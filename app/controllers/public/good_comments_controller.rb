class Public::GoodCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counseling_post, only: [:create, :destroy]
  before_action :set_post_comment, only: [:create, :destroy]

  def create
    good_comment = current_user.good_comments.new(post_comment_id: @post_comment.id)
    good_comment.save
    # コメントを「良い」と評価したという通知を作成する
    @post_comment.create_notification_by(current_user, @post_comment.id, @post_comment.user_id)
  end

  def destroy
    good_comment = current_user.good_comments.find_by(post_comment_id: @post_comment.id)
    good_comment.destroy
  end

  private

  def set_counseling_post
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
  end

  def set_post_comment
    @post_comment = PostComment.find(params[:post_comment_id])
  end
end