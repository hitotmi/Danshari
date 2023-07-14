class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_comments = PostComment.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @post_comment = PostComment.find(params[:id])
    @counseling_post = @post_comment.counseling_post
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @counseling_post = CounselingPost.find(params[:counseling_post_id])

    if params[:from_show_page] == 'true'
      # 詳細ページからのリクエストがあった場合
      flash[:post_comment] = '回答を削除しました'
      redirect_to admin_post_comments_path
    else
      # 一覧ページからのリクエストがあった場合
      flash.now[:post_comment] = '回答を削除しました'
      render :destroy_index
    end
  end
end
