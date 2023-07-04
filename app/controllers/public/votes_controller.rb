class Public::VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @counseling_post = CounselingPost.find(params[:counseling_post_id])
    @vote = @counseling_post.votes.find_or_initialize_by(user: current_user)
    @vote.option = vote_params[:option]
    # 投票が初めて作成されたものか、既存のものかを判定
    is_new_vote = @vote.new_record?

    if @vote.save
      # 投票されたことを、投稿者に通知を作成する
      @counseling_post.create_vote_notification_by(current_user, @counseling_post.id, @counseling_post.user_id, @vote.option, is_new_vote)
      redirect_to counseling_post_path(@counseling_post, anchor: 'voting-section')
      flash[:vote_notice] = "投票完了しました"
    else
      redirect_to  counseling_post_path(@counseling_post)
      flash[:vote_alert] = "投票に失敗しました。選択しなおしてください。"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:option)
  end
end
