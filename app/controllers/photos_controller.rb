class PhotosController < ApplicationController
  def index
    @photos = Photo.all
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
  end
  def photo_params
    params.require(:photo).permit(:title, :description, :sharing_mode, :image_url)
  end
end
