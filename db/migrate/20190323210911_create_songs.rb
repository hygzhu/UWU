class CreateSongs < ActiveRecord::Migration[5.2]
  def change

    create_table :sources do |t|
      t.string :name
      t.string :period
      
      t.timestamps
    end

    create_table :songs do |t|
      t.references :source, foreign_key: true
      t.timestamps
    end

  end

end
