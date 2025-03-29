# For handling game state and functions
class Game
  attr_accessor :player_word

  def initialize
    @secret_word = set_word
    @player_word = insert_blanks
  end

  def make_guess
    puts "Guess a letter"
    # debug check
    puts "Word: #{secret_word}"
    char = gets.chomp.chr
    char.match?(/[a-zA-Z]/) ? char : "Try again"
  end

  def letter_in_word?(guess)
    fill_player_word(guess) if secret_word.include?(guess)
  end

  private

  attr_reader :secret_word

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

  def insert_blanks
    str = ""
    secret_word.length.times do
      str = "#{str}_"
    end

    str.chomp
  end

  def fill_player_word(guess)
    secret_word.chars.each_index do |idx|
      player_word[idx] = guess if secret_word[idx] == guess
    end
  end
end
