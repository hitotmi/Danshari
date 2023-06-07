class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.counseling_post_id = @counseling_post.id
    unless @post_comment.save
      render 'error' # app/views/public/post_comments/error.js.erbを参照する
    else
      @post_comment_item = @post_comment.counseling_post
      @post_comment_item.create_notification_post_comment!(current_user, @post_comment.id)
    end
  end

  def destroy
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    comment = PostComment.find(params[:id])
    comment.destroy
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
