require './lib/oystercard.rb'
require './lib/stations.rb'

describe Station do
    let(:station_double) {double(:station)}
    let(:zone_double) {double(:zone)}
    let(:subject) {Station.new(station_double, zone_double)}
    it 'station has a name' do
        expect(subject.station).to eq station_double
    end

    it 'station has a zone' do
        expect(subject.zone).to eq zone_double
    end

end