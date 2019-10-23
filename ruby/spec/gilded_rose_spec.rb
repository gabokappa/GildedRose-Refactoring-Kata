# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'reduces the quality by one for a standard item' do
      items = [Item.new('sample', 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(9)
    end

    it 'reduces the sell_in by one for a standard item' do
      items = [Item.new('sample', 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq(4)
    end
  end
end
