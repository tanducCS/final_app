class UsersController < ApplicationController
  def followings
    @user = User.find(params[:id])
  end
  def followers
    @user = User.find(params[:id])
  end
  def edit
    @user_edit = User.find(params[:id])
  end
  def create_follow
    user_follow_to = params[:id]
    user_follow = current_user.id
    OnFollow.create!(follower_id: user_follow, followee_id: user_follow_to)
    redirect_to user_photos_path(current_user)
  end
  def delete_follow
    user_follow_to = params[:id]
    user_follow = current_user.id
    follow = OnFollow.where(follower_id: user_follow, followee_id: user_follow_to)
    follow[0].destroy
    redirect_to user_photos_path(current_user)
  end

  def feeds_photos
    @followees = current_user.followees
  end
  def feeds_albums
    @followees = current_user.followees
  end
end
