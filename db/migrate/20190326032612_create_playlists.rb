class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|

      t.string :name
      t.text :description
      t.string :difficulty
      t.integer :plays, :default => 0
      
      t.references :user, foreign_key: true
      t.timestamps
    end

      
    add_index :playlists, [:user_id, :created_at]

  end
end
