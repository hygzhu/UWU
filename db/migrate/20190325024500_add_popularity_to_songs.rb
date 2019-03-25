class AddPopularityToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :popularity, :integer 
  end
end
