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

    it 'quality degrades x 2 after sell by date' do
      items = [Item.new('sample', 0, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(8)
    end

    it 'quality of an item never goes negative' do
      items = [Item.new('sample', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(0)
    end

    it 'Aged Brie increases in quality per day' do
      items = [Item.new('Aged Brie', 1, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(1)
    end

    it 'Brie quality increases by 2 when sell_in negative' do
      items = [Item.new('Aged Brie', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(2)
    end

    it 'Brie continues to increase in quality by 2 after negative' do
      items = [Item.new('Aged Brie', 0, 0)]
      shop = GildedRose.new(items)
      shop.update_quality
      shop.update_quality
      expect(items[0].quality).to eq(4)
    end

    it 'quality is never more than 50' do
      items = [Item.new('Aged Brie', 0, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(50)
    end

    it 'Sulfuras attributes stay the same' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 6, 40)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(40)
      expect(items[0].sell_in).to eq(6)
    end
  end

  # describe 'Backstage passes' do
  #   it ''
  # end

end