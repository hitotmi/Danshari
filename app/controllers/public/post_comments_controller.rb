class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counseling_post, only: [:create, :destroy]

  def create
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.counseling_post_id = @counseling_post.id
    unless @post_comment.save
      render 'error' # app/views/public/post_comments/error.js.erbを参照する
    else
      flash.now[:post_comment_created] = "回答が作成されました。"
      # @post_comment_itemにコメントが紐づいている投稿を設定する
      @post_comment_item = @post_comment.counseling_post
      # コメントされたという通知を作成する
      @post_comment_item.create_notification_post_comment!(current_user, @post_comment.id)
      @post_comments = @counseling_post.post_comments.order(created_at: :desc)
    end
  end

  def destroy
    comment = PostComment.find_by(id: params[:id])
    comment.destroy
    flash.now[:post_comment_created] = '回答を削除しました'
    @post_comments = @counseling_post.post_comments.order(created_at: :desc)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def set_counseling_post
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
  end
end
