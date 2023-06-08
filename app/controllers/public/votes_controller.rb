class Public::VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @vote = @counseling_post.votes.find_or_initialize_by(user: current_user)
    @vote.option = vote_params[:option]
    if @vote.save
      redirect_to  counseling_post_path(@counseling_post)
      @message = "投票完了しました"
    else
      @message = "投票に失敗しました"
    end
    @user_vote = current_user.votes.find_by(counseling_post_id: @counseling_post.id)
  end

  private

  def vote_params
    params.require(:vote).permit(:option)
  end

end
