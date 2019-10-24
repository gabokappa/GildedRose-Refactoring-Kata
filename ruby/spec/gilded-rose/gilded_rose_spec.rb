# frozen_string_literal: true

require 'gilded_rose'
require 'item'

describe 'Standard items' do
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

    describe 'All items' do
      it 'quality of an item never goes negative' do
        items = [Item.new('sample', 0, 1)]
        shop = GildedRose.new(items)
        shop.update_quality
        shop.update_quality
        expect(items[0].quality).to eq(0)
      end

      it 'quality is never more than 50' do
        items = [Item.new('Aged Brie', 0, 49)]
        shop = GildedRose.new(items)
        shop.update_quality
        shop.update_quality
        expect(items[0].quality).to eq(50)
      end
    end
  end
