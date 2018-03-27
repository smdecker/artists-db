class CreateArtworkCategories < ActiveRecord::Migration
  def change
    create_table :artwork_categories do |t|
      t.integer :artwork_id
      t.integer :category_id
    end
  end
end