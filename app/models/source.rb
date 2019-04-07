class Source < ApplicationRecord
    has_many :active_relationships, class_name:  "SourceSongRelationship", foreign_key: "source_id", dependent: :destroy
    has_many :songs, through: :active_relationships, source: :song

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
