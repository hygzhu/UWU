class Refactor < ActiveRecord::Migration[5.2]
  def change

    add_reference :songs, :source, index: true
    add_foreign_key :songs, :source


    add_column :songs, :source_name, :string 
  end
end
