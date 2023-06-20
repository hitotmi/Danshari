class Public::CounselingPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @counseling_post = CounselingPost.new
  end

  def create
    @counseling_post = CounselingPost.new(counseling_post_params)
    @counseling_post.user_id = current_user.id
    if  @counseling_post.save
      flash[:notice] = "投稿しました。"
      redirect_to counseling_post_path(@counseling_post)
    else
      render :new
    end
  end

  def index
    if params[:content].present?
      @content = params[:content]
      @counseling_posts =  CounselingPost.search_for(@content).page(params[:page]).per(9)
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
    @post_comments = @counseling_post.post_comments.order(created_at: :desc).page(params[:page]).per(10)
    @post_comment = PostComment.new
    @vote =  @counseling_post.votes.build
    @user_vote = current_user.votes.find_by(counseling_post_id: @counseling_post.id)
    @discard_votes =  @counseling_post.votes.discard.count # 投票結果(捨てる)のカウントを取得
    @keep_votes = @counseling_post.votes.keep.count        # 投票結果(捨てない)のカウントを取得
    @either_votes = @counseling_post.votes.either.count    # 投票結果(どちらでもよい)のカウントを取得
  end

  def edit
    @counseling_post = CounselingPost.find(params[:id])
  end

  def update
    @counseling_post = CounselingPost.find(params[:id])
    if @counseling_post.update(counseling_post_params)
      flash[:notice] = "投稿を更新しました。"
      redirect_to counseling_post_path(@counseling_post)
    else
      render :edit
    end
  end

  def destroy
    @counseling_post = CounselingPost.find(params[:id])
    @counseling_post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to counseling_posts_path
  end

  private

  def counseling_post_params
    params.require(:counseling_post).permit(:title, :content, :status, :image, :usage_frequency, :star , tag_ids: [])
  end

  def is_matching_login_user
    counseling_post = CounselingPost.find(params[:id])
    unless counseling_post.user_id == current_user.id
      redirect_to counseling_posts_path
    end
  end

end
