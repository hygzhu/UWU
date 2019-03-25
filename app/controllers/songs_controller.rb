class SongsController < ApplicationController
    before_action :admin_user, only: [:create, :edit, :update, :destroy]

    def index
        @filterrific = initialize_filterrific(
            Song,
            params[:filterrific],
            select_options: {
              sorted_by: Song.options_for_sorted_by
            },
            persistence_id: "shared_key",
            default_filter_params: { sorted_by: 'created_at_desc' },
            available_filters: [
              :sorted_by,
              :search_query
            ],
            sanitize_params: true,
          ) || return

        @songs = @filterrific.find.page(params[:page])
       
        respond_to do |format|
            format.html
            format.js
        end
    end

    def show
        @song = Song.find(params[:id])
    end

    def new 
        @song = Song.new
    end

    def create
        @song = Song.new(song_params)
        if @song.save
            redirect_to songs_path
        else
          render 'new'
        end
      end
    
      def edit
        @song = Song.find(params[:id])
      end
    
      def update
        @song = Song.find(params[:id])
        if @song.update_attributes(song_params)
          # Handle a successful update.
          flash[:success] = "Song updated"
          redirect_to @song
        else
          render 'edit'
        end
      end
    
      def destroy
        Song.find(params[:id]).destroy
        flash[:success] = "Song deleted"
        redirect_to songs_path
      end

private

    def song_params
    params.require(:song).permit(:song_title, :song_artist, :song_type,
                                  :source, :source_period, :url)
    end

end
