# To deliver this notification:
#
# PhotoNotification.with(post: @post).deliver_later(current_user)
# PhotoNotification.with(post: @post).deliver(current_user)

class PhotoNotification < Noticed::Base
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
  def photo
    message&.photo
  end

  # def url
  #   user_photos_path(params[:post])
  # end
end
