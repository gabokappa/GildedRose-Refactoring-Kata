require_relative './item.rb'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Sulfuras, Hand of Ragnaros'
        next
      when 'Aged Brie'
        change_quality(item, 1)
      when 'Backstage passes to a TAFKAL80ETC concert'
        backstage_quality_change(item)
      when 'Conjured Mana Cake'
        change_quality(item, -2)
      else
        change_quality(item, -1)
      end
      item.sell_in -= 1
    end
  end

  private

  def change_quality(item, num)
    item.quality += num
    item.quality += num if item.sell_in <= 0
    item.quality = 50 if item.quality > 50
    item.quality = 0 if item.quality.negative?
  end

  def backstage_quality_change(item)
    item.quality += 1
    item.quality += 1 if item.sell_in <= 10
    item.quality += 1 if item.sell_in <= 5
    item.quality = 0 if item.sell_in <= 0
    item.quality = 50 if item.quality > 50
  end
end
