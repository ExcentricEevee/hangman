require_relative "lib/game"

# Gameplay loop
def start_game
  g = Game.new
  limit = 6

  loop do
    guess = make_guess
    puts
    if guess == "save"
      f = File.new("save.yaml", "w")
      f.puts g.to_yaml
      f.close
      puts "Game saved"
    else
      g.letter_in_word?(guess)
    end

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

def make_guess
  puts "Guess a letter"
  char = gets.chomp.downcase
  if char == "save"
    char
  else
    # TODO: fix "Try again" return string being read as an incorrect guess
    char.chr.match?(/[a-z]/) ? char.chr : "Try again"
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
