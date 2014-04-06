class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :name
      t.references :vessel_type
      t.references :fleet, index: true
      t.references :flag, index: true
      t.references :port
      t.integer :registry_no
      t.date :built_date
      t.string :yard_built
      t.integer :imo_no
      t.integer :hull_no
      t.string :call_sign

      t.float :dwt_summer
      t.float :dwt_winter
      t.float :dwt_tropical_salt
      t.float :dwt_tropical_fresh
      t.float :dwt_winter_north_atlantic

      t.float :draft_summer
      t.float :draft_winter
      t.float :draft_tropical_salt
      t.float :draft_tropical_fresh
      t.float :draft_winter_north_atlantic

      t.float :grt
      t.float :nrt
      t.float :loa

      t.float :beam
      t.float :depth
      t.float :breadth
      t.float :design_draught
      t.float :ballast_capacity
      t.float :lightship
      
      t.integer :holds
      t.integer :cranes
      t.float :cranes_swl
      t.float :cranes_outreach
      t.integer :grabs
      t.float :grabs_capacity

      t.integer :no_engines
      t.string :builder
      t.string :engine_type
      t.float :engine_rating
      t.float :ncr_rpr
      t.float :me_rpm_at_mcr
      t.float :me_power_at_mcr
      t.float :horse_power
      
      t.integer :propellers_number
      t.string :propeller_type
      t.float :propeller_diameter
      t.float :pitch_mean
      
      t.integer :bts_number
      t.integer :sts_number
      t.float :bts_rating
      t.float :sts_rating
      
      t.integer :generators_number
      t.float :total_rating
      t.float :voltage_rating
      t.float :frequency
      
      t.float :ballast_manifold_height
      t.float :laden_manifold_height
      t.float :ifo_hose_inch
      t.float :mdo_hose_inch
      t.float :ifo_rate
      t.float :mdo_rate
      t.string :ifo_location
      t.string :mdo_location
      
      t.string :rudders_number
      t.string :steering_gear_type

      t.timestamps
    end
  end
end
