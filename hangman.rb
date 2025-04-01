require_relative "lib/game"

def new_game
  g = Game.new
  g.player_word = g.insert_blanks

  limit = 6
  game_loop(g, limit)
end

def load_game
  data = YAML.load(File.open("save.yaml"))
  g = Game.new(
    data[:secret_word],
    data[:player_word],
    data[:mistakes],
    data[:wrong_letters]
  )

  limit = 6
  print_info(g, limit)
  game_loop(g, limit)
end

def game_loop(game, limit)
  loop do
    guess = make_guess
    puts
    guess == "save" ? save_game(game) : game.letter_in_word?(guess)

    print_info(game, limit)

    if game.word_complete?
      puts "You won!"
      break
    elsif game.mistakes >= limit
      puts "You've made too many mistakes; you lose!"
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

def print_info(game, limit)
  puts "Player Word: #{game.formatted_player_word}"
  puts "Mistakes: #{game.mistakes} / #{limit}"
  puts "Wrong Letters: #{game.wrong_letters}\n\n"
end

def save_game(game)
  f = File.new("save.yaml", "w")
  f.puts game.to_yaml
  f.close
  puts "Game saved"
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
  input = gets.chomp.chr.downcase
  if input == "s"
    new_game
    break
  elsif input == "l"
    load_game
    break
  end
end
