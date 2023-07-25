class Public::CounselingPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_counseling_post, only: [:show, :edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def new
    @counseling_post = CounselingPost.new
    @edit_mode = false
  end

  def create
    @counseling_post = CounselingPost.new(counseling_post_params)
    @counseling_post.user_id = current_user.id
    perform_emotion_analysis

    if @counseling_post.save
      flash[:notice] = "投稿しました。"
      redirect_to counseling_post_path(@counseling_post)
    else
      @counseling_post.image = nil
      render :new
    end
  end

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
    @post_comments = @counseling_post.post_comments.order(created_at: :desc)
    @post_comment = PostComment.new
    @vote =  @counseling_post.votes.build
    # 投稿に対するログインユーザーの投票があれば取得
    @user_vote = current_user.votes.find_by(counseling_post_id: @counseling_post.id)
    # 投票数を選択肢ごとにカウントする
    @discard_votes = @counseling_post.votes.discard.count # 投票結果(捨てる)のカウントを取得
    @keep_votes = @counseling_post.votes.keep.count        # 投票結果(捨てない)のカウントを取得
    @either_votes = @counseling_post.votes.either.count    # 投票結果(どちらでもよい)のカウントを取得
  end

  def edit
    @edit_mode = true
  end

  def update
    perform_emotion_analysis

    if @counseling_post.update(counseling_post_params)
      flash[:notice] = "投稿を更新しました。"
      redirect_to counseling_post_path(@counseling_post)
    else
      @counseling_post.reload
      render :edit
    end
  end

  def destroy
    @counseling_post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to counseling_posts_path
  end

  private

  def counseling_post_params
    params.require(:counseling_post).permit(:title, :content, :status, :image, :usage_frequency, :star, tag_ids: [])
  end

  def perform_emotion_analysis
    # "emotion_analysis" パラメータが '1' の場合（感情分析オプションが有効に設定された場合）感情分析を実行
    if params[:counseling_post][:emotion_analysis] == '1'
      sentiment_data = Language.get_data(counseling_post_params[:content])
      @counseling_post.score = sentiment_data[:score]
      @counseling_post.magnitude = sentiment_data[:magnitude]
    else
    # "emotion_analysis" パラメータが '0'に設定された場合（感情分析オプションが無効に設定された場合）スコアとマグニチュードを空にする
      @counseling_post.score = nil
      @counseling_post.magnitude = nil
    end
  end

  def set_counseling_post
    @counseling_post = CounselingPost.find(params[:id])
  end

  def is_matching_login_user
    unless @counseling_post.user_id == current_user.id
      redirect_to counseling_posts_path
    end
  end
end
