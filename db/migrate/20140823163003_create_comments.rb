class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.text :url

      t.timestamps
    end
  end
end
