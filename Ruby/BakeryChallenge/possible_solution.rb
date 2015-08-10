
TREAT_SERVINGS = {"pie" => 8, "cake" => 6, "cookie" => 1} #making this a constant, in order from most servings to least (that is important)

def bakery_num(servings, favorite_food)
  raise ArgumentError, "You can't make that food" unless TREAT_SERVINGS.key?(favorite_food)

  #instead of initializing them individually, we cna put it into a hash and easily associate with the servings hash
  order_quantity = {"pie" => 0, "cake" => 0, "cookie" => 0}
  fave_food_servings = TREAT_SERVINGS[favorite_food]

  if servings % fave_food_servings == 0
    return "You need to make #{servings/fave_food_servings} #{favorite_food}(s)."
  end

  # we know that we'll only have to fill the order with foods that have serving sizes of 
  # equal to or less than favorite_food. so, if the constant TREAT_SERVINGS is always in 
  # order by most servings : least_servings, this should return
  # an array of the treats that will potentially be part of the order
  foods = TREAT_SERVINGS.keys.drop_while {|food| food != favorite_food}

  # take_while will continue iterating until it evaluates to false or nil
  # so the last line in the block is asking if servings still have to be allocated
  foods.take_while do |food|
    order_quantity[food] = servings / TREAT_SERVINGS[food]
    servings %= TREAT_SERVINGS[food]
  end

  return "You need to make #{order_quantity["pie"]} pie(s), #{order_quantity["cake"]} cake(s), and #{order_quantity["cookie"]} cookie(s)."
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


