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

p set_word
