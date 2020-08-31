class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :photo
      t.datetime :event_start
      t.string :rsvp_send_before
      t.string :repeats_every
      t.integer :creator_id

      t.timestamps
    end
  end
end
