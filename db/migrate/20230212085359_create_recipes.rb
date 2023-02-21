class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :orient
      t.integer :difficulty
      t.integer :excecution_time
      t.text :instructions
      t.integer :portions
      t.string :photo
      t.boolean :for_review
      t.boolean :from_admin
      t.string :shape

      t.timestamps
    end
  end
end
