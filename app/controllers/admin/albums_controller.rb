module Admin
  class AlbumsController < ApplicationController
    before_action :authorize_admin
    def index
      @albums = Album.all
    end
    private
    def authorize_admin
      unless current_user&.is_admin?
        redirect_back(fallback_location: root_path, alert: "You are not authorized to access this page.")
      end
    end
  end

end