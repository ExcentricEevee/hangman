require_relative "lib/game"

g = Game.new

# Introduction
puts "\nWelcome to Hangman! A random secret word has been set,
and you must guess what it is one letter at a time.
If you type more than one letter at a time
only the first letter will be used.\n\n"

# Gameplay loop
loop do
  guess = g.make_guess
  g.letter_in_word?(guess)
  puts "Player Word: #{g.formatted_player_word}\n\n"

  if g.word_complete?
    puts "You won!"
    break
  end
end
