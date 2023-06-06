class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications.order(created_at: :desc)
  end

  def mark_read
    notification = Notification.find(params[:id])
    notification.update(checked: true)
    redirect_to notifications_path
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end

end
