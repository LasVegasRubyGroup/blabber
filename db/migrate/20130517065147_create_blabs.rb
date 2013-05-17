class CreateBlabs < ActiveRecord::Migration
	
	def change
		create_table :blabs do |t|
			t.string :text
			t.integer :user_id
			t.timestamps
		end
	end

end