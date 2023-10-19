#!/usr/bin/env ruby
require 'cgi'
cgi = CGI.new

# 選択された選択肢を取得
choices = cgi.params['choice']

# 結果をファイルに書き込む
File.open("vote_result.txt", "a") do |file|
  file.flock(File::LOCK_EX)
    choices.each do |choice|
      file.puts(choice)
    end
  file.flock(File::LOCK_UN)
end

cgi.out("type" => "text/html", "charset" => "UTF-8") do
  <<-HTML
    <html>
      <body>
        <h1>投票ありがとうございました．</h1>
        <a href="https://cgi.u.tsukuba.ac.jp/~s2313911/wp/view_result.rb">投票結果を見る</a>
        <br />
        <a href="https://cgi.u.tsukuba.ac.jp/~s2313911/wp/enquete_form.rb">投票に戻る</a>
      </body>
    </html>
  HTML
end
