module Public::NotificationsHelper

  def notification_form(notification)
    @visitor = notification.visitor
    @visitor_comment = notification.post_comment_id
    # @post_comment = PostComment.find_by(id: @visitor_comment)&.comment

    case notification.action
      when "post_comment"
        your_counseling_post = link_to 'あなたの投稿', counseling_post_path(notification.counseling_post_id), style: "font-weight: bold;"
        tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "に回答しました"
      when "favorite"
        your_counseling_post = link_to 'あなたの投稿', counseling_post_path(notification.counseling_post_id), style: "font-weight: bold;"
        tag.a(notification.visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "を参考にしました"
      when "good_comment"
        your_counseling_post = link_to 'あなた回答', counseling_post_path(notification.post_comment.counseling_post_id), style: "font-weight: bold;"
        tag.a(@visitor.name, href: user_path(@visitor), style: "font-weight: bold;") + "さんが" + your_counseling_post + "役立ったったと評価しました"
    end
  end

  def get_post_comment(notification)
    PostComment.find_by(id: notification.post_comment_id)&.comment
  end

end
