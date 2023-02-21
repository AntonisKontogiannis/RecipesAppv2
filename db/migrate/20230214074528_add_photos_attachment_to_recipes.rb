# This migration comes from active_storage (originally 20170806125915)
class AddPhotosAttachmentToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :photo, :string
  end
end
