class Refactor < ActiveRecord::Migration[5.2]
  def change

    add_column :songs, :source_name, :string 
  end
end
