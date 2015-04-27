# OBJECTIVES: 
# Your class will need to return true or false when we call the #check_card. 
# Your class needs to be initialized with a credit card number that is 
# exactly 16 digits otherwise you should receive an ArgumentError

# LUHN ALGORITHM FOR CC VALIDATION LOGIC: 
# starting with the second to last digit, double every other digit until you
# reach the first digit.

# Sum all the untouched digits and the doubled numbers, first broken down to 
# digits (10 becomes 1 + 0). If the total is a multiple of ten, you have 
# received a valid credit card number! 

#*******************************************************************************************#

# INPUT:  #initialize     object with input 16-digit integer argument
# OUPUT:  #initialize     outputs ArgumentError for invalid input (integers not 16 digits)
#         #check_card     calls #doubled_digit_array & outputs boolean true/false for valid/invalid card number
#         #doubled_digit_array (private) 
#                         calls att_reader for @card_number and outputs the arary of digit characters to sum

# STEPS:  #initialize     raise ArgumentError if input parameter is not 16 digits
#                         set input to instance variable for card number
          #check_card    call #doubled_digit_array and receive message with character array of digits to sum
#                         test and return true/false for whether evenly divisible by 10
#         #double_digit_array
#                         call private reader and receive value of @card_number instance
#                         convert to character array.
#                         avoid reverse and isolate elements to double by testing for even index            
#                         double integer converted strings at even indicies, convert back to strings, 
#                         and split into character arrays, concatinating in place.
#                         return result and send character digit array to #check_card
 


class CreditCard
 
  def initialize(card_number)
    raise ArgumentError.new("Invalid card length.") if card_number.to_s.length != 16
    @card_number = card_number
  end
 
  def check_card
    doubled_character_array.map(&:to_i).reduce(:+) % 10 == 0
  end

  private
  attr_reader :card_number #narrowing the public interface to only what's necessary
  
  def doubled_character_array
    card_number.reverse.chars.collect_concat.with_index do |element, index|
      index.even? ? (element.to_i * 2).to_s.chars : element
    end
  end

end

#test for trigger argument error message for too long input
long_number = 11111111111111112
p long_number.to_s.chars.length > 16 #=> true
puts CreditCard.new(long_number) rescue (puts $!.message == 'Invalid card length.') #=> true if triggers error message for card with > 16 digits

#test for trigger argument error message for too short input
short_number = 11111111
p short_number.to_s.chars.length < 16 #=> true
puts CreditCard.new(short_number) rescue (puts $!.message == 'Invalid card length.') #=> true if triggers error message for card with < 16 digits


# got extra valid nums for testing for various CC companies from http://www.getcreditcardnumbers.com/
card = CreditCard.new(4408041234567893)
p card.check_card  == true # => true if recognizes valid card num

card = CreditCard.new(4408041234567892)
p card.check_card == false # => true if recongnizes invalid card num

card = CreditCard.new(6011557831773117)
p card.check_card == true #=> true if recognizes valid card num

card = CreditCard.new(5475141397072742)
p card.check_card == true #=> true if recognizes valid card num

card = CreditCard.new(5475141397072743)
p card.check_card == false #=> # => true if recongnizes invalid card num