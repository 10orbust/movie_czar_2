# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :phone_number, presence: true 

  has_many(:rsvps, { :class_name => "Rsvp", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:invites, { :class_name => "Invite", :foreign_key => "sender_id", :dependent => :destroy })
  has_many(:groups, { :class_name => "Group", :foreign_key => "creator_id", :dependent => :destroy })
  has_many(:events, { :class_name => "Event", :foreign_key => "tsar_id", :dependent => :destroy })
end
