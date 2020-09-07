require './lib/boat'
require './lib/renter'
require './lib/dock'

describe Dock do
  subject { Dock.new('The Rowing Dock', 3) }
  before do
    @kayak = Boat.new(:kayak, 20)
    @patrick = Renter.new('Patrick Star', '4242424242424242')
  end

  describe '#init' do
    it 'is an instance of Dock' do
      expect(subject).to be_a Dock
    end

    it 'has name' do
      expect(subject.name).to eql 'The Rowing Dock'
    end

    it 'has a max rental time' do
      expect(subject.max_rental_time).to eql 3
    end

    it 'has an empty rental_log' do
      expect(subject.rental_log).to eql({})
    end
  end

  describe '#rent' do
    it 'adds rented boats to rental_log' do
      subject.rent(@kayak, @patrick)
      expect(subject.rental_log).to eql({ @kayak => @patrick })
    end
  end

  describe '#charge' do
    before { subject.rent(@kayak, @patrick) }

    it 'returns a hash of rental charge info' do
      3.times { @kayak.add_hour }
      subject.charge(@kayak)

      charge_hash = { card_number: '4242424242424242', amount: 60 }
      expect(subject.charge(@kayak)).to eql(charge_hash)
    end

    it "calculates rental charge using Boat's hours_rented attribute" do
      @kayak.add_hour
      subject.charge(@kayak)

      expect(subject.charge(@kayak)[:amount]).to eql 20
    end

    it "calculates rental charge using Dock's max_rental_time attribute" do
      10.times { @kayak.add_hour }
      subject.charge(@kayak)

      expect(subject.charge(@kayak)[:amount]).to eql 60
    end
  end

  describe '#return' do
    before { subject.rent(@kayak, @patrick) }

    it 'removes boat from rental log' do
      expect(subject.return(@kayak)).to eql({})
    end
  end
end
