# frozen_string_literal: true

require 'gilded_rose'
require 'item'

describe 'Standard items' do
  let(:items) { [Item.new('bread', 1, 2)]}
  let(:shop) { GildedRose.new(items) }
  it 'does not change the name' do
    # items = [Item.new('foo', 0, 0)]
    # GildedRose.new(items).update_quality
    shop.update_quality
    expect(items[0].name).to eq('bread')
  end

  it 'reduces the quality by one for a standard item' do
    # items = [Item.new('sample', 5, 10)]
    # GildedRose.new(items).update_quality
    shop.update_quality
    expect(items[0].quality).to eq(1)
  end

  it 'reduces the sell_in by one for a standard item' do
    # items = [Item.new('sample', 5, 10)]
    #     # GildedRose.new(items).update_quality
    shop.update_quality
    expect(items[0].sell_in).to eq(0)
  end

  it 'quality degrades x 2 after sell by date' do
    items = [Item.new('sample', 0, 10)]
    GildedRose.new(items).update_quality
    expect(items[0].quality).to eq(8)
  end

  describe 'All items' do
    it 'quality of an item never goes negative' do
      items = [Item.new('sample', 0, 1)]
      shop = GildedRose.new(items)
      shop.update_quality
      shop.update_quality
      expect(items[0].quality).to eq(0)
    end
  end
end
