class AddParentPostIdToComment < ActiveRecord::Migration
  def change
  	add_column :comments, :parent_post_id, :integer
  end
end
