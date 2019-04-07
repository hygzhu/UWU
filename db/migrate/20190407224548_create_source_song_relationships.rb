class CreateSourceSongRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :source_song_relationships do |t|
      t.integer :source_id
      t.integer :song_id

      t.timestamps
    end

    add_index :source_song_relationships, :source_id
    add_index :source_song_relationships, :song_id
    add_index :source_song_relationships, [:source_id, :song_id], unique: true
  end
end
