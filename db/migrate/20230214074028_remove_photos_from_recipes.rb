# This migration comes from active_storage (originally 20170806125915)
class RemovePhotosFromRecipes < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :photo
  end
end
