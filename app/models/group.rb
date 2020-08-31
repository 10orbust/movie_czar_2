# == Schema Information
#
# Table name: groups
#
#  id               :integer          not null, primary key
#  address          :string
#  description      :text
#  event_start      :datetime
#  photo            :string
#  repeats_every    :string
#  rsvp_send_before :string
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  creator_id       :integer
#
class Group < ApplicationRecord
end
