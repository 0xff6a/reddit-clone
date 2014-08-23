class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.integer :value

      t.timestamps
    end
  end
end
