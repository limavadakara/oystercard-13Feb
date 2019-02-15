require_relative 'station'
require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :journeys, :current_journey

  def initialize(journey_class = Journey, journey_log_class = JourneyLog)
    @balance = 0
    @in_journey = false
    @journey_class = journey_class
    @journey_log_class = journey_log_class

  end

  def top_up(amount)
    fail 'Max balance of #{max_balance} exceeded' if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(entry_station=nil)
    raise "The money is not enough in card." if balance <= MIN_BALANCE
    @journey_log = @journey_log_class.new
    @journey_log.start(entry_station)

  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(MINIMUM_CHARGE)

  end

  private :deduct

end
