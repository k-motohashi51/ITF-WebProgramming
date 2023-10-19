#!/usr/bin/env ruby
# encoding: utf-8

filename = 'sample3-1.txt'

counts = Hash.new(0)

File.open(filename, "r") do |file|
  # 一行ずつ読み込む
  file.each_line do |line|
    line.chomp.upcase.each_char do |char| # 小文字があれば大文字にする
      # Count only Alphabet
      if char =~ /[A-Z]/ # アルファベットなら読み込む
        counts[char] += 1
      end
    end
  end
end

# 結果の出力
counts.each do |letter, count|
  puts "#{letter}: #{count}"
end

