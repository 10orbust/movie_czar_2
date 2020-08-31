# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  custom_message :string
#  movie_watched  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  group_id       :integer
#  tsar_id        :integer
#
class Event < ApplicationRecord
    validates :group_id, :tsar_id, presence: true 
end
