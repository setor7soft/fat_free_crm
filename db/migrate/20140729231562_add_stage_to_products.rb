class AddStageToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :stage, :string, :limit => 32
  end

  def self.down
    remove_column :products, :stage
  end
end
