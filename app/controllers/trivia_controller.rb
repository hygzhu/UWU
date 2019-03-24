class TriviaController < ApplicationController
    autocomplete :song, :source
    
    def index
        render "new_game"
    end

    def new_game
        @songs = Song.order(Arel.sql('random()')).limit(1)
        @current_song = @songs.first
    end

    def submit
        @answer = params[:answer][:answer_text]
        @correct_answer = params[:correct_answer]
    end

private


end
