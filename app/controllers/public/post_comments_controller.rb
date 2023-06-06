class Public::PostCommentsController < ApplicationController

  def create
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.counseling_post_id = @counseling_post.id
    comment.save

    @post_comment_item = comment.counseling_post
    @post_comment_item.create_notification_post_comment!(current_user, comment.id)
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
