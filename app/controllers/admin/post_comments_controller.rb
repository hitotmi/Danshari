class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    flash.now[:post_comment_created] = '回答を削除しました'
  end

end
