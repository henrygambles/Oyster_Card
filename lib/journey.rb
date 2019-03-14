require_relative 'oystercard'
require_relative 'stations'

class Journey

    attr_reader :trip_log, 

    def initialize(entry_station = nil, exit_station = nil, card)
        @entry_station = entry_station
        @exit_station = exit_station
    end

    def in_journey?
        !@entry_station.nil?
      end
      #MOVE
    
      def make_trip
        @trip_log = { :entry_station => @entry_station, :exit_station => @exit_station }
      end
      #MOVE
    
      def end_trip
        store(@trip_log)
        @entry_station, @exit_station = nil, nil
      end
end