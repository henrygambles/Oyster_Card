require 'oystercard'

describe Oystercard do

  it {is_expected.to respond_to(:balance)}   
  subject(:card) {Oystercard.new}
  # subject(:card_with_money) {Oystercard.new(balance: 10)}
  #interested to further understand how syntax is operating.

  let(:journey_double) {double(:journey)}
  let(:journey_class_double) {double(:journey_class)}
  let(:trip_log_double) {double(:trip_log)}
  let(:entry_station_double) {double(:entry_station)}
  let(:exit_station_double) {double(:exit_station)}
  # journey_double = double(:journey)
  #for inside an it block
  

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

  # describe '#deduct' do 

  #   it { is_expected.to respond_to(:deduct).with(1).argument }

  #   it 'balance should change when deducted' do 
  #     expect{ card_with_money.deduct 3}.to change{ card_with_money.balance }.by -3
  #   end

  # end

  describe '#touch_in' do 

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'create a new journey when you touch in' do
      card.top_up(5)
      expect(journey_class_double).to receive(:new)
      card.touch_in(entry_station_double, journey_class_double)
    end

    it 'raises an error if balance is less than £1' do
      allow(journey_class_double).to receive(:new)
      expect{card.touch_in(entry_station_double, journey_class_double)}.to raise_error "No Money"
    end
    
    it 'stores entry station station' do
      card.top_up(5)
      allow(journey_class_double).to receive(:new)
      expect{card.touch_in(entry_station_double, journey_class_double)}.to change{card.entry_station}.from(nil).to(entry_station_double)
    end

  end

  describe '#touch_out' do
    it 'allows the customer to touch out and pass through the barriers' do
      expect(card).to respond_to(:touch_out)
    end

    it 'ends a journey when you touch out' do 
      card.touch_out
      expect(card).to have_attributes(:journey => false)
    end

    it 'deducts min fare from card when journey complete/touching out' do
      card.top_up(5)
      allow(journey_class_double).to receive(:new)
      card.touch_in(entry_station_double, journey_class_double)
      expect{subject.touch_out}.to change {subject.balance}.by(-1)
    end
    
    it 'forgets entry station' do
      card.top_up(5)
      allow(journey_class_double).to receive(:new)
      card.touch_in(entry_station_double, journey_class_double)
      expect{card.touch_out}.to change{card.entry_station}.from(entry_station_double).to(nil)
    end

  end
  
  describe '#in_journey?' do
  #   it 'checks that we are in jouney (underground)' do
  #     card_with_money.touch_in
  #     expect(card_with_money).to be_in_journey
  #   end
    it 'checks that we are in journey' do
      card.top_up(5)
      allow(journey_class_double).to receive(:new).and_return(journey_double)
      card.touch_in(entry_station_double, journey_class_double)
      expect(card).to be_in_journey
    end

    it 'checks that we are not in jouney' do
      expect(card).not_to be_in_journey
    end

  describe '#trips' do

    it 'checks that travel log is empty when initialized' do
      expect(card.travel_log).to eq []
    end

    it 'stores a trip after tap out' do
      # card.top_up(5)
      # card.touch_in(journey_double)
      # card.touch_out(journey_double)
      card.store(trip_log_double)
      expect(card.travel_log).to eq [trip_log_double]
      end

    it 'stores a journey with entry station & exit, then adds trip to travel log' do
      card.top_up(5)
      allow(journey_class_double).to receive(:new)
      card.touch_in(entry_station_double, journey_class_double)
      card.touch_out(exit_station_double)
      expect(card.travel_log).to eq [{ :entry_station => entry_station_double, :exit_station => exit_station_double }]
    end

    end
  end
  
end




