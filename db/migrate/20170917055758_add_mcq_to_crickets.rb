class AddMcqToCrickets < ActiveRecord::Migration[5.1]
  def change
    add_column :crickets, :mcq, :boolean
  end
end
