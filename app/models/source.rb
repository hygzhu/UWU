class Source < ApplicationRecord
    has_many :songs, foreign_key: "source_id"

    filterrific(
        default_filter_params: { sorted_by: 'year_desc' },
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
            "LOWER(sources.name) LIKE ?",
            "LOWER(sources.period) LIKE ?",
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
    when /^year_/
        order("sources.year #{ direction }")
    else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
    }

    # This method provides select options for the `sorted_by` filter select input.
    # It is called in the controller as part of `initialize_filterrific`.
    def self.options_for_sorted_by
    [
        ["Year (Oldest first)", "year_asc"],
        ["Year (Newest first)", "year_desc"],
    ]
    end

end
