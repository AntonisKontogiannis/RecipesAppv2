class AddMaterialsAndMatPerPortionToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :materials, :json, null: false, default: '{}'     
    add_column :recipes, :materials_per_portion, :json, null: false, default: '{}'
  end
end
