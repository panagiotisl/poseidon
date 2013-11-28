class VesselType < ActiveRecord::Base
  has_many :ships, foreign_key: "vessel_type_id"
end
