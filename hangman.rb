require_relative "lib/game"

g = Game.new
loop do
  p g.make_guess
end
