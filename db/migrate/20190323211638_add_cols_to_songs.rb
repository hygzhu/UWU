class AddColsToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :song_title, :string 
    add_column :songs, :song_artist, :string 
    add_column :songs, :song_type, :string 
    add_column :songs, :source, :string 
    add_column :songs, :source_period, :integer
    add_column :songs, :url, :string 
  end
end
