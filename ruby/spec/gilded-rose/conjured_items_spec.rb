require 'gilded_rose'
require 'item'

describe 'Conjured items' do
it 'Conjured items degrade by 2 per day' do
  items = [Item.new('Conjured Mana Cake', 6, 40)]
  GildedRose.new(items).update_quality
  expect(items[0].quality).to eq(38)
  expect(items[0].sell_in).to eq(5)
end

it 'Conjured items degrade by 4 after sell_in date' do
  items = [Item.new('Conjured Mana Cake', 0, 40)]
  GildedRose.new(items).update_quality
  expect(items[0].quality).to eq(36)
  expect(items[0].sell_in).to eq(-1)
end

it 'Conjured items cannot go in negative value' do
  items = [Item.new('Conjured Mana Cake', 0, 0)]
  GildedRose.new(items).update_quality
  expect(items[0].quality).to eq(0)
  expect(items[0].sell_in).to eq(-1)
end
  end