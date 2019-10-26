# Gilded Rose tech test

This is my proposed solution to the Gilded Rose kata, where you are tasked to add a new feature to legacy code.
The code updates increases/decreases the quality of an item each time, the method is called.

## Table of contents
* [Installation](#installation-and-usage)
* [Usage](#usage)
* [Requirements](#requirements)
* [Approach](#approach)
* [Tests](#tests)

## Installation and usage

* Clone this repository in your desired directory on your local disk
```
$ git clone git@github.com:gabokappa/GildedRose-Refactoring-Kata.git
```

* Navigate to the above directory and in the command-line run ``bundle install``
* To run tests using RSpec type in the command-line in the project's root directory ``rspec``
* To run Rubocop type in the command-line ``rubocop``

### Usage

To see the outcome of the code, navigate to the project directory and in the lib folder
run ``ruby texttest_fixture.rb`` followed by a number to represent the amount of days/times the list of items are updated for.                                                                                 


Here is a view of what this would look like in the command line for one day.
```
[user1:...e-Refactoring-Kata/ruby/lib]$ ruby texttest_fixture.rb 2   (master✱)
OMGHAI!
-------- day 0 --------
name, sellIn, quality
+5 Dexterity Vest, 10, 20
Aged Brie, 2, 0
Elixir of the Mongoose, 5, 7
Sulfuras, Hand of Ragnaros, 0, 80
Sulfuras, Hand of Ragnaros, -1, 80
Backstage passes to a TAFKAL80ETC concert, 15, 20
Backstage passes to a TAFKAL80ETC concert, 10, 49
Backstage passes to a TAFKAL80ETC concert, 5, 49
Conjured Mana Cake, 3, 6

-------- day 1 --------
name, sellIn, quality
+5 Dexterity Vest, 9, 19
Aged Brie, 1, 1
Elixir of the Mongoose, 4, 6
Sulfuras, Hand of Ragnaros, 0, 80
Sulfuras, Hand of Ragnaros, -1, 80
Backstage passes to a TAFKAL80ETC concert, 14, 21
Backstage passes to a TAFKAL80ETC concert, 9, 50
Backstage passes to a TAFKAL80ETC concert, 4, 50
Conjured Mana Cake, 2, 4
```

To compare the outcome with the 'old code' change the first line in ``textest_fixture.rb``

From ``require_relative './gilded_rose.rb'`` to ``require_relative './old_code.rb'`` Please note that the old code will not make changes to the Conjured items.

## Requirements
### Original specifications
"Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a prominent city run by a friendly innkeeper named Allison. We also buy and sell only the finest goods. Unfortunately, our goods are constantly degrading in quality as they approach their sell by date. We have a system in place that updates our inventory for us. It was developed by a no-nonsense type named Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that we can begin selling a new category of items. First an introduction to our system:

All items have a SellIn value which denotes the number of days we have to sell the item. All items have a Quality value which denotes how valuable the item is. At the end of each day our system lowers both values for every item. Pretty simple, right? Well this is where it gets interesting:
```
- Once the sell by date has passed, Quality degrades twice as fast

- The Quality of an item is never negative

- “Aged Brie” actually increases in Quality the older it gets

- The Quality of an item is never more than 50

- “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality

- “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when
there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert
```

We have recently signed a supplier of conjured items. This requires an update to our system:
```
- “Conjured” items degrade in Quality twice as fast as normal items
```
Feel free to make any changes to the UpdateQuality method and add any new code as long as everything still works correctly. However, do not alter the Item class or Items property as those belong to the goblin in the corner who will insta-rage and one-shot you as he doesn’t believe in shared code ownership (you can make the UpdateQuality method and Items property static if you like, we’ll cover for you)."*

## Approach

I decided to do the kata using Ruby. I took the original specifications outlined above and wrote a series of tests based on these specifications.
My understanding was that the client was happy with the behaviour and outcome of the original code and wanted to add a new item (Conjured) which had a different quality degradation rate.

By writing tests first, I ensured I retained the current functionality (as outlined by specification). In addition I looked at the output of the original code to determine some outcomes that weren't clear in the original spec. For example: Brie gaining quality x 2 when sell_in became negative.
As the original code was heavily nested and had multiple responsibilities I decided to take the following approach.

My process was:

- Determine the section of the original code that affected what I wanted to test
- Comment out that section 
- Writing a failing test
- Restore code to get a green test

Re-writing code:

- Once all tests are green
- Delete original code for ``update_quality`` method
- Comment out all tests except the first one
- Re-write code to pass test
- Repeat the last two steps with the next test

### Decisions

As I determined that most of the items shared similar rates of either increasing or decreasing quality I could split some responsibility into two private methods so the code would be like this:

``update_quality`` iterates through the list of items and calls the changes that apply to each item. The method dictates the change to be made
Using a case statement based on an item's name it calls the ``change_quality`` method passing the item and a number that indicates the rate of increase/decrease.

``change_quality`` is responsible for changing the actual quality attribute of that item based on the number that is passed in and adhering to limitations. (i.e it doesn't go over 50 or negative)

``backstage_quality`` As the backstage passes had complex set of specifications I decided to give them their own private method that was responsible for changing that item's quality.

I finally decided to separate the Item class from the gilded_rose.rb file.

### Trade offs

I'm aware that ``update_quality`` not only determines the changes to be made to the quality of each item, but it also reduces the ``sell_in`` by one.
At first I had an extra private method which applied the limitations (no negative qualities or go beyond 50) and reduced the sell_in, however I thought this method was taking some of the responsibility of changing the quality of the item. I therefore kept all quality related changes to  a specific method.
I could have one method solely responsible for reducing sell_in, however this still needed to be called in update_quality, so I decided to use one line to address directly. The final outcome is a reduction in number of methods and code lines, which are readable.


### Future changes

If a new items needs to be added to the item list then the case statement can be extended with the rate of quality change.
If this is a specialised item with many specifications(like backstage passes) then another private method could be used. 

### Recommendations 

- Suggest changing the Item class to include the quality increase/decrease rate. So these aren't hard coded in GildedRose and is stored in the Item instance.
- Suggest items to have an integer identifier so it doesn't rely on hard coded strings. For example, if we assume backstage passes to other concerts behave in the same way then if these were added to the item list an unnecessary addition would need to be made to the new code.
I wouldn't determine quality changes based on a string containing a specific word as that could lead to issues such what to do with a 'Conjured Aged Brie'.
 
 
 ## Tests
 
 Tests can be run using ``rspec`` in the command-line.
 
 I decided to split test files based on the type of item and their specifications. ``gilded_rose_spec`` has the tests for standard items and edge cases. The rest of the filenames are self-explanatory.
 
 I didn't mock item instances in these tests as the methods called rely on being able to change specific attributes on item instances. For a user to determine whether an issue arises with an Item rather than the GildedRose class they can look at the item_spec tests performance.
 
 In addition, I have retained the old_code in the lib directory so that the correct output from the old and the new code can be compared using the texttest_fixture.rb file.