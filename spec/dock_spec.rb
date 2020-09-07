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
      is_expected.to be_a Dock
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

    it 'has revenue of zero' do
      expect(subject.revenue).to eql 0
    end
  end

  describe '#rent' do
    it 'adds rented boats to rental_log' do
      subject.rent(@kayak, @patrick)
      expect(subject.rental_log).to eql(@kayak => @patrick)
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

    context 'when hours_rented does not exceed max_rental_time' do
      it 'calculates rental charge' do
        @kayak.add_hour
        subject.charge(@kayak)

        expect(subject.charge(@kayak)[:amount]).to eql 20
      end
    end

    context 'when hours_rented exceeds max_rental_time' do
      it 'calculates rental charge' do
        10.times { @kayak.add_hour }
        subject.charge(@kayak)

        expect(subject.charge(@kayak)[:amount]).to eql 60
      end
    end
  end

  describe '#return' do
    it 'removes boat from rental log' do
      subject.rent(@kayak, @patrick)
      subject.return(@kayak)

      expect(subject.rental_log).to eql({})
    end
  end

  describe '#log_hour' do
    it "increases boat's hours_rented attribute" do
      subject.rent(@kayak, @patrick)
      2.times { subject.log_hour }

      expect(@kayak.hours_rented).to eql 2
    end
  end

  describe '#revenue' do
    it 'calculates revenue' do
      subject.rent(@kayak, @patrick)
      5.times { subject.log_hour }
      subject.return(@kayak)

      @canoe = Boat.new(:canoe, 30)
      @joe = Renter.new('Joe Webster', '1234567890')
      subject.rent(@canoe, @joe)
      subject.log_hour
      subject.return(@canoe)

      expect(subject.revenue).to eql 90
    end
  end
end
