require_relative "lib/game"

# Gameplay loop
def start_game
  g = Game.new
  limit = 6

  loop do
    guess = g.make_guess
    puts # to put a newline after the input line
    g.letter_in_word?(guess)

    if g.mistakes >= limit
      puts "You've made too many mistakes; you lose!"
      break
    end

    puts "Player Word: #{g.formatted_player_word}"
    puts "Mistakes: #{g.mistakes} / #{limit}"
    puts "Wrong Letters: #{g.wrong_letters}\n\n"

    if g.word_complete?
      puts "You won!"
      break
    end
  end
end

# Introduction
puts "\nWelcome to Hangman! A random secret word has been set,
and you must guess what it is one letter at a time.
If you type more than one letter at a time
only the first letter will be used.\n\n"

# Main Menu
loop do
  puts "Please type (S)tart to begin a new game,"
  puts "or (L)oad to continue a saved game"
  input = gets.chomp.downcase
  if input == "s"
    start_game
    break
  elsif input == "l"
    load_game
    break
  end
end
