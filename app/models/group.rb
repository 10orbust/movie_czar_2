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
    belongs_to(:creator, { :required => false, :class_name => "User", :foreign_key => "creator_id" })
    has_many(:events, { :class_name => "Event", :foreign_key => "group_id", :dependent => :destroy })
    has_many(:invites, { :class_name => "Invite", :foreign_key => "group_id", :dependent => :destroy })
    
    validates :creator_id, :rsvp_send_before, :title, :event_start, presence: true

    def joined_members 
       members = []
       invites = Invite.where(:group_id => self.id)
       invites.where(:accecpted => true).pluck(:sender_id).each{|member_id| members.push(member_id)}
       invites.where(:accecpted => true).pluck(:receiver_id).each{|member_id| members.push(member_id)}
       return User.where(:id => members)
    end
    def past_events
    Event.where(:group_id => self.id).past_events 
    end

    def future_events
        Event.where(:group_id => self.id).future_events 
    end

end
