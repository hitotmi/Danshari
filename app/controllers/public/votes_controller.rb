class Public::VotesController < ApplicationController

  def create
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @vote = @counseling_post.votes.find_or_initialize_by(user: current_user)
    @vote.option = vote_params[:option]
    if @vote.save
      redirect_to counseling_post_path(@counseling_post), notice: '投票が完了しました。'
    else
      redirect_to counseling_post_path(@counseling_post), notice: '投票に失敗しました。'
    end
  end

  def destroy
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @vote = current_user.votes.find_by(counseling_post: @counseling_post)
    if  @vote.destroy
      redirect_to counseling_post_path(@counseling_post), notice: '投票を削除しました。'
    else
      redirect_to counseling_post_path(@counseling_post), notice: '削除に失敗しました。'
    end
  end


  private

  def vote_params
    params.require(:vote).permit(:option)
  end

end


