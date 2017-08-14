class Player
  def initialize
    print "Enter your name: "
    @name = gets.chomp
  end

  def guess
    print "Guess a new letter: "
    letter = gets.chomp.downcase

    #if !('a'..'z').include?(letter)
    #  puts "That's not a letter, try again!"
    #  guess
    #end

    letter
  end
end
