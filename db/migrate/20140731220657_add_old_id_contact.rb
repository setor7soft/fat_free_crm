class AddOldIdContact < ActiveRecord::Migration
def self.up
  add_column :contacts, :old_id, :integer
end

def self.down
  remove_column :contacts, :old_id
end
end
