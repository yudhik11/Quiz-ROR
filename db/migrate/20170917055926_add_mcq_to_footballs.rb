class AddMcqToFootballs < ActiveRecord::Migration[5.1]
  def change
    add_column :footballs, :mcq, :boolean
  end
end
