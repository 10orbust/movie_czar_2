# == Schema Information
#
# Table name: invites
#
#  id          :integer          not null, primary key
#  accecpted   :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  group_id    :integer
#  receiver_id :integer
#  sender_id   :integer
#
class Invite < ApplicationRecord
  belongs_to(:sender, { :required => false, :class_name => "User", :foreign_key => "sender_id" })
  belongs_to(:group, { :required => false, :class_name => "Group", :foreign_key => "group_id" })
  belongs_to(:receiver, { :required => false, :class_name => "User", :foreign_key => "receiver_id" })

    validates :group_id, :receiver_id, :sender_id, presence: true
    validate :unique_combination

    def unique_combination
      Invite.exists?(
        :group_id => self.group_id,
        :receiver_id => self.receiver_id,
        :sender_id => self.sender_id
      )
    end
end
