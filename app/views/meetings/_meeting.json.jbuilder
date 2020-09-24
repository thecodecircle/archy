json.extract! meeting, :id, :team_id, :content, :privacy, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
