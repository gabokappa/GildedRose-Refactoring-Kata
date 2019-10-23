

def quality

if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
  if item.quality > 0
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.quality = item.quality - 1
    end
  end
  end
