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
    
    belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })
    belongs_to(:event, { :required => false, :class_name => "Event", :foreign_key => "event_id" })
    validates :user_id, uniqueness: { scope: :event_id,
      message: "RSVP already created" }

    def self.future_events
      event_ids = self.pluck(:event_id)
      events = Event.where(:id=> event_ids).where("watch_date > ?", Date.today).pluck(:id)
      Rsvp.where(:event_id => events)
    end

    def self.attended
      self.where(:accepted => true)
    end
end
