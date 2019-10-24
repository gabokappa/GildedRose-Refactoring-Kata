require 'item'

describe Item do
  describe 'initialises' do
    it 'An item can be instantiated with name, sell_in and quality' do
      item = Item.new('bag', 15, 20)
      expect(item.name).to eq('bag')
      expect(item.sell_in).to eq(15)
      expect(item.quality).to eq(20)
    end
  end
  describe '#to_s' do
    it 'returns a string with the items attributes' do
      item = Item.new('bag', 15, 20)
      expect(item.to_s).to eq('bag, 15, 20')
    end
  end

end