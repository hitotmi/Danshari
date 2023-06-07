class Public::VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @vote = @counseling_post.votes.find_or_initialize_by(user: current_user)
    @vote.option = vote_params[:option]
    @vote.save
    @user_vote = current_user.votes.find_by(counseling_post_id: @counseling_post.id)
  end

  def destroy
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @vote = current_user.votes.find_by(counseling_post: @counseling_post)
  end


  private

  def vote_params
    params.require(:vote).permit(:option)
  end

end


