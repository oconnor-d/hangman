require "./lib/player"

class Hangman
  attr_reader :word

  @@words = File.readlines("dictionary.txt")

  def initialize
    @wrong_guesses = 10
    @player = Player.new
    @word = choose_random_word
    @wrong_letters   = []
    @correct_letters = []
  end

  def play
    display

    exited = false

    while (!is_won? && @wrong_guesses > 0 && !exited) do
      puts "Wrong Guesses Left: #{@wrong_guesses}"

      puts "Enter a letter, or 'save' to save and exit."

      guess = @player.guess
      if guess == "save"
        create_save
        exited = true
      elsif is_valid_guess?(guess)
        guess_letter(guess)
        display
      else
        puts "Invalid Guess! Try again"
      end

      puts ""
    end

    if (!is_won?)
      puts "Out of Guesses"
    elsif (!exited)
      puts "You Win!"
    else
      puts "Saved and Exited!"
    end
  end

  private

  def create_save
    print "Enter a save name: "
    save_name = gets.chomp

    File.open("saves/#{save_name}.yml", 'w') do |f|
      f.write(YAML.dump(self))
    end
  end

  def choose_random_word
    found_word = false

    while !found_word do
      word = @@words[rand(@@words.length)].chomp

      found_word = true if word.length >= 5 && word.length <= 12
    end

    word
  end

  def display
    @word.each_char do |char|
      if @correct_letters.include?(char)
        print char
      else
        print "-"
      end
    end

    puts ""
  end

  def guess_letter(letter)
    if @word.include?(letter)
      @correct_letters << letter
      puts "Correct!"
    else
      @wrong_letters << letter
      @wrong_guesses -= 1
      puts "Wrong!"
    end
  end

  def is_valid_guess?(letter)
    letter.length == 1 && !@wrong_letters.include?(letter) && !@correct_letters.include?(letter)
  end

  def is_won?
    @word.each_char do |char|
      return false if !@correct_letters.include?(char)
    end

    true
  end
end
