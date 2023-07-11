class UsersController < ApplicationController
  def followings
  end
  def followers
  end
  def edit
    @user_edit = User.find(params[:id])
  end
  def update
  end
end
