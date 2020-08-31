json.extract! invite, :id, :sender_id, :receiver_id, :accecpted, :group_id, :created_at, :updated_at
json.url invite_url(invite, format: :json)
