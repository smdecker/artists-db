class CreateMaterialCategories < ActiveRecord::Migration
  def change
    create_table :material_categories do |t|
      t.integer :material_id
      t.integer :category_id
    end
  end
end
