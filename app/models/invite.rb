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
end
