json.extract! group, :id, :title, :description, :address, :photo, :event_start, :rsvp_send_before, :repeats_every, :creator_id, :created_at, :updated_at
json.url group_url(group, format: :json)
