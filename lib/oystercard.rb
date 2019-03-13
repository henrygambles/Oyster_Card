class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  attr_reader :balance, :journey
  attr_writer :balance

  def initialize(journey = false)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    fail 'Maximum balance of 90 exceeded' if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "No Money" if @balance < MIN_BALANCE
    @journey = true
  end

  def touch_out
    @balance -= MIN_FARE
    @journey = false
  end

  def in_journey?
    @journey
  end


end
