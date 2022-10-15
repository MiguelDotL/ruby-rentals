class Rental
  include Enumerable

  attr_reader :rental_id, :building_id, :rent, :bedrooms, :bathrooms, :size_sqft, :min_to_subway, :floor, :building_age_yrs, :no_fee, :has_roofdeck, :has_washer_dryer, :has_doorman, :has_elevator, :has_dishwasher, :has_patio, :has_gym, :neighborhood, :submarket, :borough

  def initialize(rental_id, building_id, rent, bedrooms, bathrooms, size_sqft, min_to_subway, floor, building_age_yrs, no_fee, has_roofdeck, has_washer_dryer, has_doorman, has_elevator, has_dishwasher, has_patio, has_gym, neighborhood, submarket, borough)
    @rental_id = rental_id
    @building_id = building_id
    @rent = rent
    @bedrooms = bedrooms
    @bathrooms = bathrooms
    @size_sqft = size_sqft
    @min_to_subway = min_to_subway
    @floor = floor
    @building_age_yrs = building_age_yrs
    @no_fee = no_fee
    @has_roofdeck = has_roofdeck
    @has_washer_dryer = has_washer_dryer
    @has_doorman = has_doorman
    @has_elevator = has_elevator
    @has_dishwasher = has_dishwasher
    @has_patio = has_patio
    @has_gym = has_gym
    @neighborhood = neighborhood
    @submarket = submarket
    @borough = borough
  end
end
