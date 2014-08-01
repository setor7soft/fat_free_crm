class AddAssignedToToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :assigned_to, :integer
    add_index :products, :assigned_to
  end

  def self.down
    remove_column :products, :assigned_to
  end
end
