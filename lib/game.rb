# For handling game state and functions
class Game
  attr_accessor :player_word
  # for debugging purposes; player should not see secret word
  attr_reader :secret_word

  def initialize
    @secret_word = set_word
    @player_word = ""
  end

  def make_guess
    puts "Guess a letter"
    char = gets.chomp.chr
    char.match?(/[a-zA-Z]/) ? char : "Try again"
  end

  private

  def set_word
    dict = File.open("dictionary.txt")

    word_list = []
    dict.each do |word|
      word = word.chomp
      word_list.push(word) if word.length.between?(5, 12)
    end
    dict.close

    word_list.sample
  end
end
