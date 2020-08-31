# == Schema Information
#
# Table name: rsvps
#
#  id         :integer          not null, primary key
#  accepted   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#  user_id    :integer
#
class Rsvp < ApplicationRecord
end
