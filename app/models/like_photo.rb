class LikePhoto < ApplicationRecord
  belongs_to :photo
  belongs_to :user
  after_create_commit  :broadcast_notifications
  has_noticed_notifications model_name: 'Notification'

  def broadcast_notifications
    return if user == photo.user

    PhotoNotification.with(message: self).deliver_later(photo.user)

    broadcast_prepend_to "notifications_#{photo.user.id}",
                         target: "notifications_#{photo.user.id}",
                         partial: "notifications/notification",
                         locals: {user:, photo:, unread: true,type:'like_photo' }
  end

end