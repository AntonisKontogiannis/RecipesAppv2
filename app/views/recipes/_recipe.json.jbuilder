json.extract! recipe, :id, :name, :orient, :difficulty, :excecution_time, :instructions, :portions, :photo, :for_review, :from_admin, :shape, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
