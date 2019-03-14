class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  attr_reader :balance, :journey, :entry_station, :travel_log

  def initialize
    @balance = 0
    #@journey = journey
    @travel_log = []
  end

  def top_up(amount)
    fail 'Maximum balance of 90 exceeded' if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station, journey_class = Journey)
    fail "No Money" if @balance < MIN_BALANCE
    @journey = journey_class.new(entry_station, exit_station = nil, self)
    @entry_station = entry_station
  end

  def touch_out(exit_station = nil, journey = @journey)
    deduct(MIN_FARE)
    @exit_station = exit_station
    journey.make_trip
    journey.end_trip
    store(journey.trip_log)
    @exit_station = nil

  end

  def store(trip_log)
    @travel_log << trip_log
  end

  def in_journey?
    @journey.in_journey?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
