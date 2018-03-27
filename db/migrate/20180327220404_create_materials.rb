class CreateMaterials < ActiveRecord::Migration
	def change
		create_table :materials do |t|
			t.string :name
			t.string :purchase_location
			t.string :price
			t.integer :quantity
			t.text :notes
			t.string :serial
			t.string :file
			t.integer :user_id
		end
	end
end