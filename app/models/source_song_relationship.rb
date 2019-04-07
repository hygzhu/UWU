class SourceSongRelationship < ApplicationRecord
    belongs_to :source, class_name: "Source"
    belongs_to :song, class_name: "Song"

    validates :source_id, presence: true
    validates :song_id, presence: true
end
