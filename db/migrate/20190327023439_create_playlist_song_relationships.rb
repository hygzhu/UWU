class CreatePlaylistSongRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :playlist_song_relationships do |t|
      t.integer :playlist_id
      t.integer :song_id

      t.timestamps
    end
    add_index :playlist_song_relationships, :playlist_id
    add_index :playlist_song_relationships, :song_id
    add_index :playlist_song_relationships, [:playlist_id, :song_id], unique: true
  end
end
