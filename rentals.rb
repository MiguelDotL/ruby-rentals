require "csv"
require "./rental"

$data = CSV.read("./data.csv")

class Rentals
  include Enumerable

  attr_reader :rentals

  def initialize(rentals = nil)
    if rentals.nil? # ------- on init, map all data columns to instance of Rentals
      # get attributes from header row of CSV file
      attributes = $data[0].map do |attr|
        attr.downcase
            .gsub(" ", "_")
            .gsub("-", "_")
            .gsub(/[^_,A-Za-z]/, "")
      end

      csv = $data[1..-1]

      # dynamically define instance methods to read each attrubute, on a Rental class instace
      Rental.define_getters(attributes)
      # dynamically define instance variables inside of initialize method of each Rental instance
      Rental.define_initialize(attributes)

      @rentals = csv.map do |row_values| # $data[1..-1] all csv rows (except for header row)
        # initialize a new instance of Rental for each row of the CSV file (except for header row)
        Rental.new(*row_values) # pass values from each row in as |*args| (define_method(:initialize) do |*args|)
      end
    else # use Rentals instance stored in memory if one has already been instanciated
      @rentals = rentals
    end
  end

  def avg_rent
    rent_prices = rentals.map(&:rent).map(&:to_f)
    sum_rent_prices = rent_prices.reduce(:+)
    (sum_rent_prices / rent_prices.count).round(2)
  end

  def mean(attribute)
    mapped_attr = rentals.map do |rental|
      rental.send(attribute).to_f
    end

    return (mapped_attr.reduce(:+) / rentals.count).round(2)
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
