class LikeAlbum < ApplicationRecord
  belongs_to :user
  belongs_to :album
  after_create_commit  :broadcast_notifications
  has_noticed_notifications model_name: 'Notification'

  def broadcast_notifications
    return if user == album.user

    LikeAlbumNotification.with(message: self).deliver_later(album.user)

    broadcast_prepend_to "notifications_#{album.user.id}",
                         target: "notifications_#{album.user.id}",
                         partial: "notifications/notification",
                         locals: {user:, album:, unread: true,type:'like_album', }
  end
end