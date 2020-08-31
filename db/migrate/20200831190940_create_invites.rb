class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :accecpted
      t.integer :group_id

      t.timestamps
    end
  end
end
