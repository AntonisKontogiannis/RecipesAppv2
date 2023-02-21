json.extract! review, :id, :recipe_id, :rating, :created_at, :updated_at
json.url review_url(review, format: :json)
