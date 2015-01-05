
class CreditCard
 
  def initialize(card_number)
    raise ArgumentError.new("Invalid card length.") if card_number.to_s.length != 16
    @card_number = card_number
  end
 
  def check_card
    validate = @card_number.to_s.chars.collect_concat.with_index do |element, index|
      index.even? ? (element.to_i * 2).to_s.chars : element #since its 16 digits and arithmetic order of
    end                                                     #operations doesn't change the outcome for this, 
    validate.map(&:to_i).reduce(:+) % 10 == 0               #can avoid extra reverse operations 
  end
end

#####################################################################################

class CreditCard

  def initialize(card_number)
    raise ArgumentError.new("Invalid card length.") if card_number.to_s.length != 16
    @card_number = card_number
  end

  def check_card
    card_digit_arr = @card_number.to_s.chars.map(&:to_i)
    summed_digit_arr = card_digit_arr.reverse.each_with_index.map do |x , i| #or map.with_index
      i.odd? ? ((x * 2).to_s.chars.map(&:to_i).inject(0) {|sum, ind| sum + ind}) : x
    end
    summed_digit_arr.reduce(:+) % 10 == 0
  end
end

##################################### REGEX ###########################################

class CreditCard

  def initialize(card_number)
     raise ArgumentError.new("Invalid card length.") if card_number.to_s.length != 16
    @card_number = card_number
  end

  def check_card
   validate = @card_number.to_s.reverse.gsub!(/(\d)(\d)/){|match| $1 + ($2.to_i*2).to_s} #match groups
   validate.chars.map(&:to_i).reduce(:+) % 10 == 0
  end

end
