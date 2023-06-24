class Admin::CounselingPostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @counseling_posts = if params[:content].present?
                          CounselingPost.search_for(params[:content])
                        elsif params[:tag_ids].present?
                          CounselingPost.tagged_with(params[:tag_ids])
                        elsif params[:status].present?
                          CounselingPost.with_status(params[:status])
                        else
                          CounselingPost.all
                        end
    @counseling_posts = @counseling_posts.order(created_at: :desc).page(params[:page]).per(9)
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
