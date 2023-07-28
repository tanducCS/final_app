# To deliver this notification:
#
# LikeAlbumNotification.with(post: @post).deliver_later(current_user)
# LikeAlbumNotification.with(post: @post).deliver(current_user)

class LikeAlbumNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    params[:message]
  end
  def creator
    message&.user
  end
  def album
    message&.album
  end

  # def url
  #   user_photos_path(params[:post])
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
end
