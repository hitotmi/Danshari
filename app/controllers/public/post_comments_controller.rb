class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.counseling_post_id = @counseling_post.id
    unless @post_comment.save
      render 'error' # app/views/public/post_comments/error.js.erbを参照する
    else
      flash.now[:notice] = 'コメントを投稿しました'
      @post_comment_item = @post_comment.counseling_post
      @post_comment_item.create_notification_post_comment!(current_user, @post_comment.id)
      @post_comments = @counseling_post.post_comments.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def destroy
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    comment = PostComment.find_by(id: params[:id])
    comment.destroy
    flash.now[:notice] = '投稿を削除しました'
    @post_comments = @counseling_post.post_comments.order(created_at: :desc).page(params[:page]).per(10)
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
