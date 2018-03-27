class CreateArtworks < ActiveRecord::Migration
  def change
  	create_table :artworks do |t|
      t.string :title
      t.string :date
      t.text :medium
      t.text :dimensions
      t.text :notes
      t.string :file
      t.integer :user_id
    end
  end
end
