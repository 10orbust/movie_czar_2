class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :tsar_id
      t.string :movie_watched
      t.integer :group_id
      t.string :custom_message

      t.timestamps
    end
  end
end
