class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  attr_reader :balance, :journey, :entry_station

  def initialize(journey = false)
    @balance = 0
    @journey = journey
    @entry_station = nil
  end

  def top_up(amount)
    fail 'Maximum balance of 90 exceeded' if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "No Money" if @balance < MIN_BALANCE
    @journey = true
    @entry_station = station
  end

  def touch_out
    @balance -= MIN_FARE
    @entry_station = nil
    @journey = false
  end

  def in_journey?
    @journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
