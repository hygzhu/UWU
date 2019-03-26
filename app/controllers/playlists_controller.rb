class PlaylistsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create, :destroy, :edit, :update]
    before_action :correct_user,   only: [:destroy, :edit, :update]

    def index
        @playlists = Playlist.all.paginate(page: params[:page], per_page: 15)
    end

    def show
        @playlist = Playlist.find(params[:id])
    end

    def new
        @playlist = Playlist.new
    end

    def create
        @playlist = current_user.playlists.build(playlist_params)
        if @playlist.save
            flash[:success] = "Playlist created!"
            redirect_to root_url
        else
            render 'new'
        end
    end

    def edit 
        @playlist = Playlist.find(params[:id])
    end

    def update
        @playlist = Playlist.find(params[:id])
        if @playlist.update_attributes(playlist_params)
          # Handle a successful update.
          flash[:success] = "Playlist updated"
          redirect_to @playlist
        else
          render 'edit'
        end
    end

    def destroy
        Playlist.find(params[:id]).destroy
        flash[:success] = "Playlist deleted"
        redirect_back(fallback_location: playlists_path) 
    end

private

    def playlist_params
        params.require(:playlist).permit(:name, :description, :difficulty)
    end

    def correct_user
        @playlist = current_user.playlists.find_by(id: params[:id])
        redirect_to root_url if @playlist.nil?
    end

end
