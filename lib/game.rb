# For handling game state and functions
class Game
  attr_accessor :player_word, :mistakes, :wrong_letters

  def initialize
    @secret_word = set_word
    @player_word = insert_blanks
    @mistakes = 0
    @wrong_letters = []
  end

  def formatted_player_word
    str = []
    player_word.chars.map { |char| str.push("#{char} ") }
    str.join
  end

  def make_guess
    puts "Guess a letter"
    # debug check
    puts "Word: #{secret_word}"
    char = gets.chomp.chr.downcase
    char.match?(/[a-z]/) ? char : "Try again"
  end

  def letter_in_word?(guess)
    if player_word.include?(guess) || wrong_letters.include?(guess)
      puts "You guessed this already, please try another letter."
    elsif secret_word.include?(guess)
      fill_player_word(guess)
    else
      mistake_made(guess)
    end
  end

  def word_complete?
    player_word == secret_word
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

  def mistake_made(guess)
    puts "#{guess} isn't in the word."
    self.mistakes += 1
    wrong_letters.push(guess)
  end
end
