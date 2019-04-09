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


    filterrific(
        default_filter_params: { sorted_by: 'default_desc' },
        available_filters: [
          :sorted_by,
          :search_query
        ]
    )

    scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
        (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
        terms.map {
        or_clauses = [
            "LOWER(playlists.name) LIKE ?",
            "LOWER(playlists.description) LIKE ?",
        ].join(' OR ')
        "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| ["%#{e}%"] * num_or_conditions }.flatten
    )
    }

    scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^default_/
        where("playlists.user_id = 1")
    when /^year_/
        order("playlists.name #{ direction }")
    else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
    }

    # This method provides select options for the `sorted_by` filter select input.
    # It is called in the controller as part of `initialize_filterrific`.
    def self.options_for_sorted_by
    [
        ["Default", "default_desc"],
        ["Year (Oldest first)", "year_asc"],
        ["Year (Newest first)", "year_desc"]
    ]
    end

end
