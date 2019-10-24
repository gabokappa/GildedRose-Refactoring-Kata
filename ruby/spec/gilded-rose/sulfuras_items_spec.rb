require 'gilded_rose'
require 'item'


describe 'Sulfuras' do
  it 'Sulfuras attributes stay the same' do
    items = [Item.new('Sulfuras, Hand of Ragnaros', 6, 60)]
    GildedRose.new(items).update_quality
    expect(items[0].quality).to eq(60)
    expect(items[0].sell_in).to eq(6)
  end
  end