require 'gilded_rose'
require 'item'

describe GildedRose do
  describe 'Backstage passes' do
    it 'quality increases by one each day' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 20, 15)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(16)
      expect(items[0].sell_in).to eq(19)
    end

    it 'quality increases by 2 when sell_in is 10 days' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 15)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(17)
      expect(items[0].sell_in).to eq(9)
    end

    it 'quality increases by 3 when sell_in is 5 days' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 4, 15)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(18)
      expect(items[0].sell_in).to eq(3)
    end

    it 'quality drops to zero after concert' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 40)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(0)
      expect(items[0].sell_in).to eq(-1)
    end

    it "doesn't exceed quality 50" do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(50)
      expect(items[0].sell_in).to eq(9)
    end
  end
end