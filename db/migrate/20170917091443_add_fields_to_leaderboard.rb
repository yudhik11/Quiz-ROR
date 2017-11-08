class AddFieldsToLeaderboard < ActiveRecord::Migration[5.1]
  def change
    add_column :leaderboards, :cmax, :integer, default: -1
    add_column :leaderboards, :fmax, :integer, default: -1
    add_column :leaderboards, :bmax, :integer, default: -1
    add_column :leaderboards, :hmax, :integer, default: -1
    add_column :leaderboards, :ccur, :integer, default: 0
    add_column :leaderboards, :fcur, :integer, default: 0
    add_column :leaderboards, :bcur, :integer, default: 0
    add_column :leaderboards, :hcur, :integer, default: 0
  end
end
