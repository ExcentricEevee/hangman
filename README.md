# Hangman

This is a toy project for practicing files and serialization. This is a standard game of Hangman where a word with 5 to 12 characters is chosen at random from a dictionary file, and the player must guess the letters of the word before making too many wrong guesses.

The game will feature being able to choose between starting a new game or loading a previously saved game. When in the middle of a game, you can choose to save the current state of the game instead of making a guess, serealizing the game data into a file that can be optionally loaded at the main menu. Repeat saves will always use the same file, however, so any future saves will overwrite previous ones.

This is a project from [The Odin Project][1], which can be [found here][2].

[1]: https://www.theodinproject.com/
[2]: https://www.theodinproject.com/lessons/ruby-hangman
