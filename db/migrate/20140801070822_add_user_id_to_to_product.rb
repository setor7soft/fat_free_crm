class AddUserIdToToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :user_id, :integer
    add_index :products, :user_id
  end

  def self.down
    remove_column :products, :user_id
  end
end
