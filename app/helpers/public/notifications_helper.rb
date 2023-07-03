module Public::NotificationsHelper

  def notification_form(notification)
    @visitor = notification.visitor
    @visitor_comment = notification.post_comment_id
    your_counseling_post = link_to 'あなたの投稿', counseling_post_path(notification.counseling_post_id), style: "font-weight: bold;"

    case notification.action
    when "post_comment"
      tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "に回答しました"
    when "favorite"
      tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "を参考リスト追加しました"
    when "good_comment"
      tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "を「グッドアドバイス」と評価しました"
    when "vote_discard"
      tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "に「捨てる」を選択し、投票しました"
    when "vote_keep"
      tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "に「捨てない」を選択し、投票しました"
    when "vote_either"
      tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "に「どちらでもよい」を選択し、投票しました"
    when "vote_change_to_discard"
      tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "を「捨てる」に再投票しました"
    when "vote_change_to_keep"
      tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "を「捨てない」に再投票しました"
    when "vote_change_to_either"
      tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "を「どちらでもよい」に再投票しました"
    end
  end

  def get_post_comment(notification)
    PostComment.find_by(id: notification.post_comment_id)&.comment
  end

end
