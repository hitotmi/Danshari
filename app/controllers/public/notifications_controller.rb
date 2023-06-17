class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications.order(created_at: :desc)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    flash[:notice] = "通知を全て削除しました。"
    redirect_to notifications_path
  end

end
