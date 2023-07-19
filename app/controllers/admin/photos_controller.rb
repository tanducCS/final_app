module Admin
  class PhotosController < ApplicationController
    def index
      @pagy, @photos = pagy(Photo.all)
    end
  end
end