class AddNameAssoToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :name_asso, :string, :limit => 64,  default: ""
  end

  def self.down
    remove_column :contacts, :name_asso
  end
end
