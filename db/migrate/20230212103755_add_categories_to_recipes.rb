class AddCategoriesToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :categories, :text, array: true, default: []    
  end
end
