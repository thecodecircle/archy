json.extract! document, :id, :user_id, :content, :description, :created_at, :updated_at
json.url document_url(document, format: :json)
