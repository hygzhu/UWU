class TriviaController < ApplicationController
    autocomplete :song, :source, :full => true do |items|
        ActiveSupport::JSON.encode( items.uniq{ |i| i["value"] } )
    end
    
    def index
    end

    def new_simple_game
        @songs = Song.order(Arel.sql('random()')).limit(1)
        @current_song = @songs.first
    end

    def simple_submit
        @params = params
        @song = Song.find(params[:song_id])
    end
    

    def playlist_select
        @playlists = Playlist.all.paginate(page: params[:page], per_page: 15)
    end

    def new_playlist_game
    end

    def playlist_submit
    end

private


end
