class Playlist < ApplicationRecord
    belongs_to :user
    
    has_many :active_relationships, class_name:  "PlaylistSongRelationship", foreign_key: "playlist_id", dependent: :destroy
    has_many :songs, through: :active_relationships, source: :song

    validates :user_id, presence: true
    validates :description, presence: true, length: { maximum: 140 }

    default_scope -> { order(created_at: :desc) }

    # Add song to playlist
    def add_song(song)
        songs << song
    end

    # Removes a song
    def remove_song(song)
        songs.delete(song)
    end

    # Returns true if the playlist has the song
    def has_song?(song)
        songs.include?(song)
    end

end
