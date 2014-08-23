class RemoveUrlColumnFromComment < ActiveRecord::Migration
  def change
  	remove_column :comments, :url
  end
end
