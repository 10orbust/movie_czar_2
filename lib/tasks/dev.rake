desc "Create the repeating event and all of the RSVPS"
task({ :new_events=> :environment}) do
    #Finds all the events in the next 24 hours
    events = Event.where("watch_date > ? and watch_date < ?", Date.today, Date.today + 1.day)

    #Creates the new events based on how far in the future they are
    events.each do |old_event|
        group = old_event.group
        event = Event.new
        event.custom_message = "Please add any important info"
        event.movie_watched = "Not Yet Picked"
        event.group_id = old_event.group_id
            if group.repeats_every == "week"
                event.watch_date = old_event.watch_date + 7.days
            elsif group.repeats_every == "two_weeks"
                event.watch_date = old_event.watch_date + 14.days
            elsif group.repeats_every == "month"
                event.watch_date = old_event.watch_date + 1.month
            elsif group.repeats_every == "six_months"
                event.watch_date = old_event.watch_date + 6.month
            elsif group.repeats_every == "year"
                event.watch_date = old_event.watch_date + 1.year
            end
        event.watch_date
        event.save 

        #Sets up all the Rsvp's for current members. 
        group.joined_members.each do |member|
            rsvp = Rsvp.new
            rsvp.accepted = false
            rsvp.event_id = event.id
            rsvp.user_id = member.id 
            rsvp.save
        end

    end

end


task({ :pick_tsar=> :environment}) do
    events = Event.where("watch_date > ? and watch_date < ?", Date.today + 0, Date.today + 1)
   
    events.each do |event| 
        possible_tsars = []
            event.rsvps.where(:accepted => true).each do |rsvp|
                    Event.where(:tsar => rsvp.user_id).count 
                    attendance_count = Rsvp.where("user_id = ? and accepted = ?", rsvp.user.id, true).count
                    possible_tsars.push({:user => rsvp.user.first_name, :user_id => rsvp.user.id, :count => Event.where(:tsar => rsvp.user_id).count, :attendance => attendance_count })
             end
        final_tsars = []
        possible_tsars.each do |tsar|
            ratio = tsar[:count] / tsar[:attendance]
            if final_tsars.empty? 
             final_tsars.push({:user => tsar[:user], :user_id => tsar[:user_id], :ratio => ratio})
            else  
                
                if final_tsars.first[:ratio] == ratio
                    final_tsars.push({:user => tsar[:user], :user_id => tsar[:user_id], :ratio => ratio})
                elsif ratio < final_tsars.first[:ratio]
                    final_tsars = []
                    final_tsars.push({:user => tsar[:user], :user_id => tsar[:user_id], :ratio => ratio})
                end
            end
        end
         sample_tsar = final_tsars.pluck(:user_id).sample
        p final_tsar = User.find_by(:id => sample_tsar)
    end

    p "pick_tsar"
end

task({ :reminder_rsvp=> :environment}) do
    
    events1 = Event.where("watch_date > ? and watch_date < ?", Date.today + 3, Date.today + 4)
    

    emails = []
    events1.each do |event|
        if event.group.rsvp_send_before == "3"
            event.rsvps.where(:accepted => false).each do |rsvp|
                emails.push(rsvp.user.email)
            end
        end
    end
    
    events2 = Event.where("watch_date > ? and watch_date < ?", Date.today + 2, Date.today + 3)
    events2.each do |event|
        if event.group.rsvp_send_before == "2"
            event.rsvps.where(:accepted => false).each do |rsvp|
                emails.push(rsvp.user.email)
            end
        end
    end

    
    events3 = Event.where("watch_date > ? and watch_date < ?", Date.today + 1, Date.today + 2)
    events3.each do |event|
        if event.group.rsvp_send_before == "1"
            
            event.rsvps.where(:accepted => false).each do |rsvp|


                emails.push(rsvp.user.email)
            end

        end
    end
    
    
    
    
    # p events.count 
    # p events.order(:watch_date).first.watch_date
    # p events.order(:watch_date).last.watch_date
end