#!/usr/bin/env ruby
require 'cgi'
cgi = CGI.new

# 投票結果のカウント
results = Hash.new(0)
File.open("vote_result.txt", "r") do |file|
  while (choice = file.gets)
    results[choice.chomp] += 1
  end
end

# 投票結果のHTML出力
cgi.out("type" => "text/html", "charset" => "UTF-8") do
  <<-HTML
    <html>
      <body>
        <h1>投票結果</h1>
        <ul>
          #{results.map { |choice, count| "<li>選択肢#{choice}: #{count}票</li>" }.join}
        </ul>
        <a href="https://cgi.u.tsukuba.ac.jp/~s2313911/wp/enquete_form.rb">投票に戻る</a>
      </body>
    </html>
  HTML
end
