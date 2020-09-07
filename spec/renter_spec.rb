require './lib/boat'
require './lib/renter'

describe Renter do
  subject { Renter.new('Joe Webster', '424224242424') }

  describe '#init' do
    it 'is an instance of Renter' do
      is_expected.to be_a Renter
    end

    it 'has a name' do
      expect(subject.name).to eql 'Joe Webster'
    end

    it 'has a credit card number' do
      expect(subject.credit_card_number).to eql '424224242424'
    end
  end
end
