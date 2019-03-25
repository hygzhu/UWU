class Song < ApplicationRecord
    filterrific(
        default_filter_params: { sorted_by: 'created_at_desc' },
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
    num_or_conditions = 3
    where(
        terms.map {
        or_clauses = [
            "LOWER(songs.source) LIKE ?",
            "LOWER(songs.song_title) LIKE ?",
            "LOWER(songs.song_artist) LIKE ?"
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
    when /^created_at_/
        order("songs.created_at #{ direction }")
    when /^popularity_/
        order("songs.created_at #{ direction }")
    else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
    }

  # This method provides select options for the `sorted_by` filter select input.
  # It is called in the controller as part of `initialize_filterrific`.
  def self.options_for_sorted_by
    [
      ["Added date (newest first)", "created_at_desc"],
      ["Added date (oldest first)", "created_at_asc"],
      ["Popularity (Lowest first)", "popularity_asc"],
      ["Popularity (Highest first)", "popularity_desc"],
    ]
  end
end
