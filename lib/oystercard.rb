require_relative 'station'
require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :journeys, :current_journey

  def initialize(journey_class = Journey, station_class = Station)
    @balance = 0
    @in_journey = false
    @journeys = []
    @journey_class = journey_class
    @station_class = station_class

  end

  def top_up(amount)
    fail 'Max balance of #{max_balance} exceeded' if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(entry_station)
    raise "The money is not enough in card." if balance <= MIN_BALANCE
    entry_station = @station_class.new("Liverpool, 1)
    @current_journey = @journey_class.new(entry_station)
  end

  def touch_out(exit_station)
    @current_journey.finish(exit_station)
    deduct(MINIMUM_CHARGE)
    @journeys << @current_journey

  end

  private :deduct

end
