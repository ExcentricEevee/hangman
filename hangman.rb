=begin
Make a hangman game that loads a 5 to 12 letter word from a dictionary file.
The game will be player vs CPU, where you must guess the letters of the secret word
within X number of incorrect guesses. Actually making a hangman is optional, you merely
have to indicate how many guesses they've made. Players should be able to save
in the middle of the game instead of making a letter guess, and able to load a saved game
in lieu of loading a new game.
=end

require 'pry'
require 'json'

module Dictionary
  def filter_dictionary(dictionary)
    File.open(dictionary, 'r') do |file|
      lines = file.readlines
      filtered_list = lines.reduce(Array.new) do |list, line|
        #reduce dictionary down to words between 5 and 12 letters
        if line.chomp.length >= 5 && line.chomp.length <= 12
          list.push(line.chomp)
        end
        list
      end

      filtered_list
    end
  end

  def get_word
    word_list = filter_dictionary('5desk.txt')
    word = word_list[rand(word_list.length)]
  end
end

module JSONable
  def to_json
    hash = {}
    self.instance_variables.each do |var|
      hash[var] = self.instance_variable_get(var)
    end

    hash.to_json
  end

  def from_json!(string)
    JSON.load(string).each do |var, value|
      self.instance_variable_set(var, value)
    end
  end
end

#needs encapsulation; display of incorrect letters
class Hangman
  include Dictionary, JSONable
  attr_reader :word
  attr_accessor :answer, :mistakes, :incorrect

  def initialize
    @word = get_word.split("")
    @answer = Array.new(@word.length, "_")
    @incorrect = Array.new
    @mistakes = 7
  end

  #to keep #welcome DRY
  def cycle
    gameover = false
    #keep going until all letters are guessed or they're out of mistakes
    until gameover
      gameover = turn
    end
  end

  def welcome
    puts "Welcome to Hangman!"
    puts "Discover the secret word by guessing one letter at a time.\n\n"
    puts "#[Debug] The word is: #{@word.join}#"

    puts "New game, or loading a save?"
    response = gets.chomp
    #needs cleaning up; put the gameover/turn loop into its own method
    if (response.downcase.include?("new"))
      cycle
    elsif (response.downcase.include?("load"))
      File.open('save.json', 'r') do |file|
        self.from_json!(file)
      end

      cycle
    end
  end

  def turn

    puts "#{@answer.join(" ")}\nMistakes left: #{@mistakes}	Incorrect: #{@incorrect.join(" ")}\n\n"
    print "Guess a letter, or save game: "
    guess = gets.downcase.chomp

    if guess == "save"
      File.open('save.json', 'w') do |file|
        file.puts(self.to_json)
      end
    elsif !(guess.length == 1)
      puts "Please use one letter at a time.\n\n"
    elsif (self.incorrect.include?(guess) || self.answer.include?(guess))
      puts "You guessed this already!\n\n"
    else
      count = 0
      self.word.each_with_index do |char, idx|
        #check is case insensitive while maintaining caps on original word
        if (char.downcase == guess)
          self.answer[idx] = guess
          count += 1
        end
      end

      if count == 0
        puts "That letter isn't in the word!"
        self.mistakes -= 1
        self.incorrect.push(guess)
      end

      #Check if they won or lost before the next turn
      gameover_check
    end
  end

  #for the next method, "gameover_check," to keep it DRY
  def response
    response = gets.chomp
    if (response.downcase == "yes" || response.downcase == "y")
      initialize
      welcome
      return true
    elsif (response.downcase == "no" || response.downcase == "n")
     return true
    end
  end

  def gameover_check
    if (self.answer.include?("_") == false)
      puts "#{@answer.join(" ")}"
      puts "You did it! Clever stuff you pulled off there.\nDo you want to play again? (y/n)"
      response
    elsif (self.mistakes <= 0)
      puts "You're out of guesses! The word was: #{@word.join}\nDo you want to play again? (y/n)"
      response
    end
  end

end

game = Hangman.new
game.welcome