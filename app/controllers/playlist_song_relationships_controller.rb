class PlaylistSongRelationshipsController < ApplicationController
    before_action :logged_in_user
    before_action :playlist_owner

    def create
        song = Song.find(params[:song_id])
        playlist = Playlist.find(params[:playlist_id])

        if playlist.has_song?(song)
            flash[:danger] = "Song already added!"
            redirect_to @playlist
        else
            playlist.add_song(song)
            flash[:success] = "Song added!"
            redirect_to @playlist
        end

    end

    def destroy
    end
end
