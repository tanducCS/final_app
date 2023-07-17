module Admin
  class UsersController < ApplicationController
    def index
      @pagy, @users = pagy(User.all)
    end
    def edit
      @edit_user = User.find params[:id]
    end
    def update
      @edit_user = User.find params[:id]
      if @edit_user.update(user_param)
        redirect_to admin_users_path, notice: 'User was successfully updated'
      else
        render admin_user_path(@edit_user)
      end


    end

    def destroy
      delete_user = User.find params[:id]
      delete_user.destroy
      redirect_to admin_users_path
    end

    def user_param
      params.require(:user).permit(:first_name, :last_name, :email, :active, :avatar_url)
    end
  end
end