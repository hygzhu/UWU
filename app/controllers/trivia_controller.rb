class TriviaController < ApplicationController
    autocomplete :song, :source, :full => true do |items|
        ActiveSupport::JSON.encode( items.uniq{ |i| i["value"] } )
    end
    
    def index
    end

    def new_game
        @songs = Song.order(Arel.sql('random()')).limit(1)
        @current_song = @songs.first
    end

    def submit
        @params = params
        @song = Song.find(params[:song_id])
    end

private


end
