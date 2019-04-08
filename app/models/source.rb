class Source < ApplicationRecord
    has_many :songs, foreign_key: "source_id"
end
