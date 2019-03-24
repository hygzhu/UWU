class TriviaController < ApplicationController
    def index
        render "new_game"
    end

    def new_game
        @songs = Song.order("RANDOM()").limit(1)
        @current_song = @songs.first
    end

    def submit
        @answer = params[:answer][:answer_text]
        @correct_answer = params[:correct_answer]
    end

private


end
