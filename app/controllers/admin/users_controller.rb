module Admin
  class UsersController < ApplicationController
    def index
      @users = User.all
    end
    def destroy
      delete_user = User.find params[:id]
      delete_user.destroy
      redirect_to admin_users_path
    end
  end
end