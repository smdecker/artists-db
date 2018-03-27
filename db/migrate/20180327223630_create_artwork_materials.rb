class CreateArtworkMaterials < ActiveRecord::Migration
  def change
    create_table :artwork_materials do |t|
      t.integer :artwork_id
      t.integer :material_id
    end
  end
end
