class Public::GoodCommentsController < ApplicationController

  def create
    post_comment = PostComment.find(params[:post_comment_id])
    good_comment = current_user.good_comments.new(post_comment_id: post_comment.id)
    good_comment.save
    redirect_to request.referer
  end

  def destroy
    post_comment = PostComment.find(params[:post_comment_id])
    good_comment = current_user.good_comments.find_by(post_comment_id: post_comment.id)
    good_comment.destroy
    redirect_to request.referer
  end

end
