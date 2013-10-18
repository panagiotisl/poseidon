class AddForeignKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :affiliation_id, :integer
  end
end
