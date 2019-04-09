class TriviaController < ApplicationController
    autocomplete :song, :source_name, :full => true do |items|
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
        @filterrific = initialize_filterrific(
            Playlist,
            params[:filterrific],
            select_options: {
              sorted_by: Playlist.options_for_sorted_by
            },
            persistence_id: false,
            default_filter_params: { sorted_by: 'default_desc' },
            available_filters: [
              :sorted_by,
              :search_query
            ],
            sanitize_params: true,
          ) || return

        @playlists = @filterrific.find.page(params[:premade_playlist_page]).per_page(6)
       
        respond_to do |format|
            format.html
            format.js
        end
    end

    def new_playlist_game

        if !params[:start].nil?
            #New game setup
            @playlist = Playlist.find(params[:playlist])

            if !@playlist.songs.any?
                flash[:danger] = "That playlist has no songs"
                redirect_to trivia_path
                return
            end

            @song_ids = @playlist.songs.shuffle.map(&:id)
            @song_id = @song_ids.pop
            @song_completed_ids = []
            @song_completed_ids << @song_id
            @song = Song.find(@song_id)
        else
            #Grab params from post and set them for new render
            @playlist = Playlist.find(params[:playlist_id])
            @song_ids = params[:song_ids].split(" ").map(&:to_i)
            @song_completed_ids = params[:song_completed_ids].split(" ").map(&:to_i)
            @song_id = @song_ids.pop
            @song_completed_ids << @song_id
            @song = Song.find(@song_id)
        end

    end

    def playlist_submit
        #Grab params from the post and set them for new render
        @playlist = Playlist.find(params[:playlist_id])
        @song_ids = params[:song_ids].split(" ").map(&:to_i)
        @song_completed_ids = params[:song_completed_ids].split(" ").map(&:to_i)
        @song_id = params[:song_id].to_i
        @song = Song.find(@song_id)
        @params = params
    end

private


end
