require './lib/boat'
require './lib/renter'
require './lib/dock'

describe Dock do
  subject { Dock.new('The Rowing Dock', 3) }

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
    it 'add rented boats to rental_log' do
      kayak = Boat.new(:kayak, 20)
      patrick = Renter.new('Patrick Star', '4242424242424242')
      subject.rent(kayak, patrick)

      expect(subject.rental_log).to eql({ kayak => patrick })
    end
  end
end
