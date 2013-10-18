class AddIndexToAffiliationsName < ActiveRecord::Migration
  def change
    add_index :affiliations, :name, unique: true
  end
end
