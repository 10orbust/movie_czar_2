json.extract! rsvp, :id, :user_id, :accepted, :event_id, :created_at, :updated_at
json.url rsvp_url(rsvp, format: :json)
