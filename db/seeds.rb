# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.destroy_all 

#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  phone_number           :string


20.times do 
    user = User.new 
    user.first_name = Faker::Name.first_name
    user.last_name = Faker::Name.last_name 
    user.email = "#{user.first_name}@email.com"
    user.phone_number = "815-342-1628"
    user.password = "password"
    user.password_confirmation = "password"
    
    user.save! 
end
p User.first
p " #{User.count} users"
users = User.all 


#  address          :string
#  description      :text
#  event_start      :datetime
#  photo            :string
#  repeats_every    :string
#  rsvp_send_before :string
#  title            :string
#  creator_id       :integer


Group.destroy_all
    repeat = ["week", "two_weeks", "month", "six_months", "year"]
    send_before_days = ["1", "2", "3"]
3.times do 
    group = Group.new 
    group.address = Faker::Address.full_address
    group.description = "These are test groups please change"
    group.event_start = Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :evening) #=> "2014-09-19 20:21:03 -0700"
    group.photo = "https://picsum.photos/200"
    group.repeats_every = repeat.sample
    group.rsvp_send_before = send_before_days.sample
    group.title = Faker::Company.name
    group.creator_id = users.sample.id 
    group.save
end

groups = Group.all 

p "#{Group.count} groups"

Event.destroy_all

#  custom_message :string
#  movie_watched  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  group_id       :integer
#  tsar_id        :integer

groups.each do |group|
    event = Event.new
    event.custom_message = "test message"
    event.movie_watched = Faker::Movie.title
    event.group_id = group.id 
    event.tsar_id = users.sample.id
    event.watch_date = group.event_start
    event.save 
    end

20.times do 
    group = groups.sample
    event = Event.new
    event.custom_message = "test message"
    event.movie_watched = Faker::Movie.title
    event.group_id = group.id 
    event.tsar_id = users.sample.id
        if group.repeats_every == "week"
            event.watch_date = group.event_start + 7.days
        elsif group.repeats_every == "two_weeks"
            event.watch_date = group.event_start + 14.days
        elsif group.repeats_every == "month"
            event.watch_date = group.event_start + 1.month
        elsif group.repeats_every == "six_months"
            event.watch_date = group.event_start + 6.month
        elsif group.repeats_every == "year"
            event.watch_date = group.event_start + 1.year
        end
    event.save 
end

p "#{Event.count} Events"

events = Event.all 

Invite.destroy_all

#  accecpted   :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  group_id    :integer
#  receiver_id :integer
#  sender_id   :integer

50.times do 
    invite = Invite.new
    invite.group_id = groups.sample.id
    invite.accecpted = Faker::Boolean.boolean
    invite.sender_id = users.sample.id
    invite.receiver_id = users.sample.id 
    invite.save
end

p "#{Invite.count} Invites"

Rsvp.destroy_all

#  accepted   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#  user_id    :integer

100.times do
    rsvp = Rsvp.new
    rsvp.accepted = Faker::Boolean.boolean
    rsvp.event_id = events.sample.id 
    rsvp.user_id = users.sample.id 
    rsvp.save
end

p "#{Rsvp.count} Rsvps"

