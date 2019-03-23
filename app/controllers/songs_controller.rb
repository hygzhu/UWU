class SongsController < ApplicationController

    def index
        @songs = Song.all.paginate(page: params[:page], per_page: 15)
      end

    def show
        @song = Song.find(params[:id])
    end

end
