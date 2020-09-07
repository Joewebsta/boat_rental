class Dock
  attr_reader :name, :max_rental_time, :rental_log
  # attr_accessor :rental_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
  end

  def rent(boat, renter)
    rental_log[boat] = renter
  end

  def charge(boat)
    renter = rental_log[boat]
    price = boat.price_per_hour
    hours = boat.hours_rented
    cost = hours > max_rental_time ? (price * max_rental_time) : (price * hours)
    {
      card_number: renter.credit_card_number,
      amount: cost
    }
  end

  def return(boat)
    rental_log.delete(boat)
    rental_log
  end

  def log_hour
    rental_log.each { |boat, _renter| boat.add_hour }
  end
end
