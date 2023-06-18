class Admin::CounselingPostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:content].present?
      @content = params[:content]
      @counseling_posts =  CounselingPost.search_for(@content).order(created_at: :desc).page(params[:page]).per(9)
    elsif params[:tag_ids].present?
      tag_post_ids = PostTag.where(tag_id: params[:tag_ids]).pluck(:counseling_post_id)
      @counseling_posts = CounselingPost.where(id: tag_post_ids).order(created_at: :desc).page(params[:page]).per(9)
    elsif params[:status].present?
      @counseling_posts = CounselingPost.where(status: params[:status]).order(created_at: :desc).page(params[:page]).per(9)
    else
      @counseling_posts = CounselingPost.all.order(created_at: :desc).page(params[:page]).per(9)
    end
  end

  def show
    @counseling_post = CounselingPost.find(params[:id])
  end

  def destroy
    @counseling_post = CounselingPost.find(params[:id])
    if current_admin
      @counseling_post.destroy
      redirect_to admin_counseling_posts_path, notice: '投稿が削除されました'
    else
      redirect_to admin_counseling_posts_path, notice: '削除できませんでした'
    end
  end

end
