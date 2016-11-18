require 'pp'
require 'grit'
require 'natto'
repo = Grit::Repo.new(ARGV[0])
user_name = ARGV[1]

words = []
repo.log.each do |log|
  natto_mecab = Natto::MeCab.new

  next if log.message.include?('Merge pull request ')

  if user_name
    next unless log.author.name == user_name
  end

  natto_mecab.parse(log.message.force_encoding('UTF-8')) do |n|
    words << n.surface
  end
end

words_and_count = Hash.new(0)
words.each do |word|
  words_and_count[word] += 1
end

pp words_and_count.sort_by { |_, v| -v }