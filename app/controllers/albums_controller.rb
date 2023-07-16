class AlbumsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end
  def new
    @album = Album.new
  end
  def create
    current_user.albums.create!(album_params)
    redirect_to user_albums_path(current_user)
  end
  def edit
    @edit_album = Album.find(params[:id])
  end
  def update
    @update_album = Album.find(params[:id])
    @update_album.update(album_params)
    redirect_to user_albums_path(current_user)
  end
  def destroy
    @delete_album = Album.find(params[:id])
    @delete_album.destroy
    redirect_to user_albums_path(current_user)
  end
  def album_params
    params.require(:album).permit(:title, :description, :sharing_mode, {images: []})
  end
end
