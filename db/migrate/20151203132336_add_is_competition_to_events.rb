class AddIsCompetitionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :is_competition, :boolean
  end
end
