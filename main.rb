require 'pp'
require 'grit'
require 'natto'
repo = Grit::Repo.new(ARGV[0])
words = []
repo.log.each do |log|
  natto_mecab = Natto::MeCab.new
  natto_mecab.parse(log.message.force_encoding('UTF-8')) do |n|
    words << n.surface
  end
end

words_and_count = Hash.new(0)
words.each do |word|
  words_and_count[word] += 1
end

pp words_and_count.sort_by{|_, v| -v }