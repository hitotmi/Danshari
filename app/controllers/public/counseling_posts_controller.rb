class Public::CounselingPostsController < ApplicationController

  def new
    @counseling_post = CounselingPost.new
  end

  def create
    @counseling_post = CounselingPost.new(counseling_post_params)
    @counseling_post.user_id = current_user.id
    if  @counseling_post.save
      redirect_to counseling_posts_path
    else
      render :new
    end
  end

  def index
    if params[:content].present?
      @content = params[:content]
      @counseling_posts =  CounselingPost.search_for(@content)
    elsif params[:tag_ids].present?
      tag_post_ids = PostTag.where(tag_id: params[:tag_ids]).pluck(:counseling_post_id)
      @counseling_posts = CounselingPost.where(id: tag_post_ids).order(created_at: :desc)
    else
      @counseling_posts = CounselingPost.all.order(created_at: :desc)
    end
  end

  def show
    @counseling_post = CounselingPost.find(params[:id])
    @post_comment = PostComment.new
    @vote =  @counseling_post.votes.build
    @user_vote = current_user.votes.find_by(counseling_post_id: @counseling_post.id)
  end

  def edit
    @counseling_post = CounselingPost.find(params[:id])
  end

  def update
    @counseling_post = CounselingPost.find(params[:id])
    if  @counseling_post.update(counseling_post_params)
      redirect_to counseling_post_path(@counseling_post)
    else
      render :edit
    end
  end

  def destory
    @counseling_post = CounselingPost.find(params[:id])
    @counseling_post.destroy
    redirect_to counseling_posts_path
  end

  def counseling_post_params
    params.require(:counseling_post).permit(:title, :content, :status, :image, :usage_frequency, :star , tag_ids: [])
  end

end
