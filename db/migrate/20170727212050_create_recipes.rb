class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :api_id, null: false

      t.timestamps
    end
  end
end
