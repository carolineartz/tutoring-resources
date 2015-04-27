require 'forwardable'

class BakeryMenu
  extend Forwardable
  attr_reader :menu

  def initialize
    @menu = []
  end

  # DON'T do this stuff at DBC unless you're highly prepared to defend your approach
  # thse could just be created as normal methods, #add_to_menu and #remove_from_menu with pushing and deleting from @menu
  def_delegator :@menu, :push, :add_to_menu
  def_delegator :@menu, :delete, :remove_from_menu

  def to_s
    "BAKERY MENU\n" << @menu.each_with_object("") do |menu_item, menu_display|
      menu_display << "#{menu_item.food_type}, serves #{menu_item.num_servings}\n"
    end
  end
end

# DON'T do this stuff at DBC unless you're highly prepared to defend your approach
# for all intents and purposes this makes a class with only instance variables and behaves similarly to hashes
MenuItem = Struct.new(:food_type, :num_servings)
BakeryOrder = Struct.new(:servings, :preferred_food_type)


class OrderFiller

  def initialize(current_menu, order)
    @current_menu = current_menu.menu
    @order = order
    @quantities = Hash.new(0)
    @servings_left = @order.servings

    check_availability
    @preferred_food_servings = preferred_menu_item.num_servings
  end

  def generate_report
    set_preferred_quantity
    fill_remainder
    order_report
  end

  private
  def check_availability
    raise ArgumentError, "You can't make that food" unless preferred_menu_item
  end

  def preferred_menu_item
    @current_menu.find {|item| item.food_type == @order.preferred_food_type}
  end

  def set_preferred_quantity
    @quantities[@order.preferred_food_type] = @servings_left / @preferred_food_servings
    @servings_left %= @preferred_food_servings
  end

  def fill_remainder
    fillers = @servings_left.zero? ? [] : sort_by_servings(filler_items)
    fillers.reverse_each do |item|
      @quantities[item.food_type] = @servings_left / item.num_servings
      @servings_left %= item.num_servings
    end
  end

  def filler_items
    @current_menu.find_all {|item| item.num_servings < @preferred_food_servings}
  end

  def sort_by_servings(menu_items)
    menu_items.sort_by(&:num_servings)
  end

  def order_report
    print "You need to make \n"
    if @quantities.length == 1
      puts "#{@quantities[@order.preferred_food_type]} #{@order.preferred_food_type}(s)"
    else
      @current_menu.to_a.each do |item|
        puts "#{@quantities[item.food_type]} #{item.food_type}(s)"
      end
    end
  end

end

pie = MenuItem.new("pie", 8)
cake = MenuItem.new("cake", 6)
cookie = MenuItem.new("cookie", 1)

menu = BakeryMenu.new

menu.add_to_menu(pie, cake, cookie)

order1 = BakeryOrder.new(24, "cake")
order2 = BakeryOrder.new(41, "pie")
order3 = BakeryOrder.new(24, "cookie")

order4 = BakeryOrder.new(4, "pie")
order5 = BakeryOrder.new(130, "pie")


order6 = BakeryOrder.new(41, "cake")
order7 = BakeryOrder.new(46, "pie")
order8 = BakeryOrder.new(47, "pie")

orders = [order1, order2, order3, order4, order5, order6, order7, order8]
orders.each {|order| OrderFiller.new(menu, order).generate_report}