class CreateGlobalSettings < ActiveRecord::Migration[6.1]
    def change
      create_table :global_settings do |t|
        t.string :name
        t.text :value, array: true, default: [] 
        t.timestamps
      end
    end
  end