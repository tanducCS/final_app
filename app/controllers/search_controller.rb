class SearchController < ApplicationController

  def search_params (key)
    if params[:q] == nil
      params[:q] = session[search_key key]
    end
    if params[:q]
      session[search_key key] = params[:q]
    end
    params[:q]
  end
  def index
    @followees = current_user.followees
    # find from the input of user that current user follow
    if params[:q] === ""
      @q = Photo.ransack(search_params "photo")
      @pagy1, @photos1 = pagy_countless(Photo.where(user_id: @followees.ids), items: 10)
    else
      @q = Photo.where(user_id: @followees.ids).ransack(search_params "photo")
      photos = @q.result(distinct: true).order(created_at: :desc)
      @pagy1, @photos1 = pagy_countless(photos, items: 10)
    end
    respond_to do |format|
      format.turbo_stream
    end
  end

  def search_album
    @followees = current_user.followees
    if params[:q] === ""
      @q = Album.ransack(search_params "album")
      @pagy1, @albums1 = pagy_countless(Album.where(user_id: @followees.ids), items: 10)
    else
      @q = Album.where(user_id: @followees.ids).ransack(search_params "album")
      albums = @q.result.order(created_at: :desc)
      puts albums.size
      @pagy1, @albums1 = pagy_countless(albums, items: 10)
    end

    respond_to do |format|
      format.turbo_stream
    end
  end



  protected
  # GENERATE A GENERIC SESSION KEY BASED ON THE CONTROLLER NAME
  def search_key (key)
    "#{key}_search".to_sym
  end
end