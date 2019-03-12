require 'oystercard'

describe Oystercard do

  it {is_expected.to respond_to(:balance)}   
  subject(:card) {Oystercard.new}
  subject(:card_with_money) {Oystercard.new(balance: 10)}
  #interested to further understand how syntax is operating.
  

  describe '#Balance' do
 
    it 'default balance is zero' do
      expect(card.balance).to eq 0
    end
  end

  describe '#Top_up' do

    it 'Balance should change when topped up' do
      expect{ card.top_up 30}.to change{ card.balance }.by 30
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAX_BALANCE
      card.top_up(maximum_balance)
      expect{ card.top_up 1 }.to raise_error("Maximum balance of #{maximum_balance} exceeded")
    end

  end

  describe '#deduct' do 

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'balance should change when deducted' do 
      expect{ card_with_money.deduct 3}.to change{ card_with_money.balance }.by -3
    end

  end

  describe '#touch_in' do 

    it 'allows the customer to touch in and pass through the barriers' do
      expect(card_with_money).to respond_to(:touch_in)
    end

    it 'starts a journey when you touch in' do
      card_with_money.touch_in
      expect(card_with_money).to have_attributes(:journey => true)
      #expect(card.touch_in).to eq(true)
    end

    # it 'raises error if balance less than minimum fare' do
    #   expect { card.balance }.to raise_error("Insufficient funds")
    # end

  end

  describe '#touch_out' do
    it 'allows the customer to touch out and pass through the barriers' do
      expect(card).to respond_to(:touch_out)
    end

    it 'ends a journey when you touch out' do 
      card.touch_out
      expect(card).to have_attributes(:journey => false)
    end

  end
  
  describe '#in_journey?' do
    it 'checks that we are in jouney (underground)' do
      card_with_money.touch_in
      expect(card_with_money).to be_in_journey
    end

    it 'checks that we are not in jouney' do
      expect(card).not_to be_in_journey
    end

  end
end



