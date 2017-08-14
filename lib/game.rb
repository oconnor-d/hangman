require "yaml"
require "./lib/hangman"
require "./lib/player"

class Game
  def initialize
    print "Load a new or saved game (new/save): "
    response = gets.chomp
    if response == "new"
      @hangman = Hangman.new
    else
      @hangman = load_save
    end

    @hangman.play
  end

  private

  def load_save
    print_saves

    print "Enter what save you want ot load: "

    save_name = gets.chomp

    YAML.load_file("saves/#{save_name}.yml")
  end

  def print_saves
    puts "All Saves: "

    Dir.glob("saves/*") do |save_name|
      save_name = save_name.to_s[6..save_name.to_s.length-5]

      puts "-- #{save_name}"
    end
  end
end

Game.new
