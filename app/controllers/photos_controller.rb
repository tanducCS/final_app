class PhotosController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @pagy, @photos = pagy(Photo.where(user_id: params[:user_id]),items: 16)
  end
  def new
    @photo = Photo.new
  end
  def create
    user = current_user.photos.create!(photo_params)
    redirect_to user_photos_path(current_user)
  end
  def show
  end
  def edit
    @edit_photo = Photo.find(params[:id])
  end
  def update
    @update_photo = Photo.find(params[:id])
    @update_photo.update(photo_params)
    redirect_to user_photos_path(current_user)
  end
  def destroy
    @delete_photo = Photo.find(params[:id])
    @delete_photo.destroy
    redirect_to user_photos_path(current_user)
  end


  def photo_params
    params.require(:photo).permit(:title, :description, :sharing_mode, :image_url)
  end
end
