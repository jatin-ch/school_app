json.extract! enrollment, :id, :batch_id, :created_at, :updated_at
json.url enrollment_users_url(enrollment, format: :json)
