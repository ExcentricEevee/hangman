=begin
Make a hangman game that loads a 5 to 12 letter word from a dictionary file.
The game will be player vs CPU, where you must guess the letters of the secret word
within X number of incorrect guesses. Actually making a hangman is optional, you merely
have to indicate how many guesses they've made. Players should be able to save
in the middle of the game instead of making a letter guess, and able to load a saved game
in lieu of loading a new game.
=end

require 'pry'

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

class Hangman
  include Dictionary
  attr_reader :word
  attr_accessor :answer, :mistakes

  def initialize
    @word = get_word.split("")
    @answer = Array.new(@word.length, "_")
    @mistakes = 7
  end

  def start
    puts "Welcome to Hangman!\n\n"
    puts "Discover the secret word by guessing one letter at a time.\nPress [Enter] to start"
    puts "#[Debug] The word is: #{@word.join}#"
    gets

    gameover = false
    #keep going until all letters are guessed or they're out of mistakes
    until gameover
      gameover = turn
    end
  end

  def turn
    puts "#{@answer.join(" ")}\nMistakes left: #{@mistakes}\n\n"
    print "Guess a letter: "
    guess = gets.downcase.chomp

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
    end

    #Check if they won or lost before the next turn
    gameover_check
  end

  #for the next method "gameover_check" to keep it DRY
  def response
    response = gets.chomp
    if (response.downcase == "yes" || response.downcase == "y")
      initialize
      start
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
game.start