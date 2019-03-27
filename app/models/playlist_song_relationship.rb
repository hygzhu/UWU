class PlaylistSongRelationship < ApplicationRecord
    belongs_to :playlist, class_name: "Playlist"
    belongs_to :song, class_name: "Song"

    validates :playlist_id, presence: true
    validates :song_id, presence: true
end
