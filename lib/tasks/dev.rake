desc "Create the repeating event and all of the RSVPS"
task({ :new_events=> :environment}) do
    

    p "new_events"


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
    
    events = Event.where("watch_date > ? and watch_date < ?", Date.today + 3, Date.today + 4)
    
    emails = []
    events.each do |event|
        event.rsvps.where(:accepted => false).each do |rsvp|
            emails.push(rsvp.user.email)
        end
    end

    p emails 
    
    
    # p events.count 
    # p events.order(:watch_date).first.watch_date
    # p events.order(:watch_date).last.watch_date
end