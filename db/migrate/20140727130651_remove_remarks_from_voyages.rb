class RemoveRemarksFromVoyages < ActiveRecord::Migration
  def change
    remove_column :voyages, :remarks, :string
  end
end
