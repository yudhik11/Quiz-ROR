class CreateLeaderboards < ActiveRecord::Migration[5.1]
  def change
    create_table :leaderboards do |t|
      t.references :user, foreign_key: true
      t.integer :Football,default: 0
      t.integer :Cricket,default: 0
      t.integer :Hollywood,default: 0
      t.integer :Bollywood,default: 0

      t.timestamps
    end
  end
end
