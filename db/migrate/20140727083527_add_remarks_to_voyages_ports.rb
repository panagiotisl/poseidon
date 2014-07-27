class AddRemarksToVoyagesPorts < ActiveRecord::Migration
  def change
    add_column :voyages_ports, :remarks, :string
  end
end
