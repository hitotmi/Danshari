class Public::PostCommentsController < ApplicationController

  def create
    counseling_post = CounselingPost.find(params[:counseling_post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.counseling_post_id = counseling_post.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
