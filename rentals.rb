require "csv"
require "./rental"

$data = CSV.read("./data.csv")

class Rentals
  include Enumerable

  attr_reader :rentals

  def initialize(rentals = nil)
    if rentals.nil? # on init, map all data columns to instance of Rentals
      @rentals = $data[1..-1].map do |d|
        Rental.new(*d)
      end
    else
      @rentals = rentals
    end
  end

  def avg_rent
    rent_prices = rentals.map(&:rent).map(&:to_f)
    sum_rent_prices = rent_prices.reduce(:+)
    (sum_rent_prices / rent_prices.count).round(2)
  end

  def each
    rentals.each do |rental|
      yield(rental)
    end
  end

  # build a method to query CSV data
  def where(conditions)
    results = rentals.find_all do |rental|
      conditions.all? do |key, value|
        rental.send(key) == value
      end
    end
    return Rentals.new(results)
  end

  #
end
