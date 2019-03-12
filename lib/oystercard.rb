class Oystercard
  START_BALANCE = 0
  MAX_BALANCE = 90
  attr_reader :balance

  def initialize(balance = START_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    fail 'Max balance reached' if (amount + balance) > MAX_BALANCE
    @balance += amount
  end

end
