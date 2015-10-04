json.array!(@vocab_words) do |vocab_word|
  json.extract! vocab_word, :id, :word, :lesson
  json.url vocab_word_url(vocab_word, format: :json)
end
