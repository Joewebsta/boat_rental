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
  end
end
