class GroceryList
  def initialize
    @items = []
  end

  def add_item(*items)
    @items += items
  end

  def remove_item(*items)
    items.each do |item|
      puts @items.include?(item) ? "1 #{@items.delete_at(@items.index(item)).name} removed" : "There is no #{item.name} on your list."
    end
  end

  def display_list
    puts '*----------*'
    puts 'GROCERY LIST'
    puts '*----------*'
    @items.group_by(&:name).each_pair do |item_name, item_array|
      puts "#{item_array.length} #{item_name} - \$#{(item_array.first.price) * (item_array.length)}"
    end
    puts '----------------------------'
    puts "Total: \$#{total_price} for #{@items.length} items. "
  end

  def total_price
    @items.map(&:price).inject(&:+)
  end
end

class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

list = GroceryList.new

block_cheese = Item.new('Block Cheddar Cheese', 5)
shredded_cheese = Item.new('Shredded Cheddar Cheese', 4)
dozen_eggs = Item.new('Dozen Eggs', 3)
chocolate_chex = Item.new('Chocolate Chex', 5)
gallon_skim_milk = Item.new('Gallon Skim Milk', 3.5)
tortilla_chips = Item.new('Tortilla Chips', 4)
fish = Item.new('Salmon', 5)

list.add_item(block_cheese, block_cheese, shredded_cheese, tortilla_chips)
list.display_list
puts ''

list.add_item(dozen_eggs)
list.display_list
puts ''

list.add_item(chocolate_chex)
list.display_list
puts ''

list.add_item(chocolate_chex, gallon_skim_milk)
list.display_list
puts ''

list.remove_item(dozen_eggs)
list.display_list
puts ''

list.add_item(shredded_cheese)
list.display_list
puts ''

list.remove_item(fish, shredded_cheese)
list.display_list
puts ''

list.add_item(shredded_cheese)
list.display_list
puts ''
