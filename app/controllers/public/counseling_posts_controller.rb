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
    @counseling_posts = CounselingPost.all.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def destory
  end

  def counseling_post_params
    params.require(:counseling_post).permit(:title, :content, :status, :image, :usage_frequency, :star)
  end

end
