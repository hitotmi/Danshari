module Public::NotificationsHelper

  def notification_form(notification)
    @visitor = notification.visitor
    @visitor_comment = notification.post_comment_id
    @post_comment = PostComment.find_by(id: @visitor_comment)&.comment

    case notification.action
    when "post_comment"
      your_counseling_post = link_to 'あなたの投稿', counseling_post_path(notification.counseling_post_id), style: "font-weight: bold;"
      tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "に回答しました"
    # when "good_comment"
    # when "favorite"
    end
  end

end
