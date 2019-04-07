class AddSourceYear < ActiveRecord::Migration[5.2]
  def change
    add_column :sources, :year, :integer 
  end
end
