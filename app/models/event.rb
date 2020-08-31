# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  custom_message :string
#  movie_watched  :string
#  watch_date     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  group_id       :integer
#  tsar_id        :integer
#
class Event < ApplicationRecord
    belongs_to(:tsar, { :required => false, :class_name => "User", :foreign_key => "tsar_id" })
    belongs_to(:group, { :required => false, :class_name => "Group", :foreign_key => "group_id" })
    has_many(:rsvps, { :class_name => "Rsvp", :foreign_key => "event_id", :dependent => :destroy })
    validates :group_id, :tsar_id, :watch_date, presence: true 
    validates :watch_date, uniqueness: true
end
