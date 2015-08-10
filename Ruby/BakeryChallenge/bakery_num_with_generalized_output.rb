
TREAT_SERVINGS = {"pie" => 8, "cake" => 6, "cookie" => 1}

def bakery_num(servings, favorite_food)
  raise ArgumentError.new("You can't make that food") unless TREAT_SERVINGS.key?(favorite_food)

  TREAT_SERVINGS.keys.each_with_object(order_quantity = {}) { |food, order|  order[food] = 0 }
  
  if servings % TREAT_SERVINGS[favorite_food] == 0
    return "You need to make #{servings/TREAT_SERVINGS[favorite_food]} #{favorite_food}(s)."
  end

  foods = TREAT_SERVINGS.keys.drop_while { |food| food != favorite_food }

  foods.take_while do |food|
    order_quantity[food] = servings / TREAT_SERVINGS[food]
    servings %= TREAT_SERVINGS[food]
  end
  
  reversed_arrays = order_quantity.to_a.map(&:reverse)
  formatter = reversed_arrays.map { |quantity, food| [quantity, "#{food}(s)"].join(' ') }
  "You need to make #{formatter[0..-2].join(", ")}, and #{formatter.last}."
end





#-----------------------------------------------------------------------------------------------------
# DRIVER TEST CODE

p bakery_num(24, "cake") == "You need to make 4 cake(s)."
p bakery_num(41, "pie") == "You need to make 5 pie(s), 0 cake(s), and 1 cookie(s)."
p bakery_num(24, "cookie") == "You need to make 24 cookie(s)."
p bakery_num(4, "pie") == "You need to make 0 pie(s), 0 cake(s), and 4 cookie(s)."
p bakery_num(130, "pie") == "You need to make 16 pie(s), 0 cake(s), and 2 cookie(s)."
# p bakery_num(3, "apples") # this will raise an ArgumentError

p bakery_num(41, "cake") == "You need to make 0 pie(s), 6 cake(s), and 5 cookie(s)." 
p bakery_num(46, "pie") == "You need to make 5 pie(s), 1 cake(s), and 0 cookie(s)." 
p bakery_num(47, "pie") == "You need to make 5 pie(s), 1 cake(s), and 1 cookie(s)."




