require 'oystercard'

describe Oystercard do

  subject(:card) {Oystercard.new}
  describe '#Balance' do

    it 'default balance is zero' do
      expect(card.balance).to eq Oystercard::START_BALANCE
    end
  end

  describe '#Top_up' do
    it 'Responds to top_up method' do
      expect(card).to respond_to(:top_up)
    end

    it 'Balance should change when topped up' do
      expect(card.top_up(5)).to eq(5)
    end
  end

  it 'Error msg raised when max balance reached' do
    expect{ card.top_up(100) }.to raise_error('Max balance reached')
  end

end
