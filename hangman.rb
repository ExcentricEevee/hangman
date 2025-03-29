require_relative "lib/game"

g = Game.new
loop do
  guess = g.make_guess
  g.letter_in_word?(guess)
end
