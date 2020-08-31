class AddWatchDateToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :watch_date, :datetime
  end
end
