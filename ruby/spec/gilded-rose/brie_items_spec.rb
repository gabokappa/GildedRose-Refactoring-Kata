require 'gilded_rose'
require 'item'

describe 'Brie items' do
  it 'Aged Brie increases in quality per day' do
    items = [Item.new('Aged Brie', 1, 0)]
    GildedRose.new(items).update_quality
    expect(items[0].quality).to eq(1)
    expect(items[0].sell_in).to eq(0)
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
    expect(items[0].sell_in).to eq(-2)
  end

  it 'quality is never more than 50' do
    items = [Item.new('Aged Brie', 0, 49)]
    shop = GildedRose.new(items)
    shop.update_quality
    shop.update_quality
    expect(items[0].quality).to eq(50)
  end
end