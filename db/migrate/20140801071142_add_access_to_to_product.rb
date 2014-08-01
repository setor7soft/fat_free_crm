class AddAccessToToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :access, :integer, :limit => 8, :default => "Public" # %w(Private Public Shared)

  end

  def self.down
    remove_column :products, :access
  end
end
