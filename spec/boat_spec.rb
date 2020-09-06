require './lib/boat'

describe Boat do
  subject { Boat.new(:kayak, 20) }

  describe '#init' do
    it 'is an instance of Boat' do
      expect(subject).to be_a Boat
    end

    it 'has a type' do
      expect(subject.type).to eql :kayak
    end

    it 'has a price per hour' do
      expect(subject.price_per_hour).to eql 20
    end

    it 'has 0 hours rented by default' do
      expect(subject.hours_rented).to eql 0
    end
  end
end
