#!/usr/bin/env ruby
# encoding: utf-8

require 'cgi'
cgi = CGI.new

file_name = "question.txt"

begin

  # テキストファイルから質問と選択肢を読み込む
  question = '' # 質問
  choices = []  # 選択肢
  File.open(file_name, "r") do |file|
    question = file.gets&.chomp # nilが返されたときに，chompを呼び出さない
    
    # 一行ずつ読み込む
    while (choice = file.gets)
      choice.chomp! # エスケープ削除
      choices << choice unless choice.empty?  # 空の選択肢は追加しない
    end
  end

  # 質問もしくは選択肢がからの場合，例外を発生させる．
  if question.nil? || question.empty?
    raise "Error: The question is not specified in question.txt."
  elsif choices.empty?
    raise "Error: No choices are specified in question.txt."
  end

  # HTMLフォームの生成
  cgi.out("type" => "text/html", "charset" => "UTF-8") do
    <<-HTML
      <html>
        <body>
          <form action="https://cgi.u.tsukuba.ac.jp/~s2313911/wp/vote.rb" method="post">
            <h1>#{question}</h1>
            #{choices.map.with_index { |choice, index|
              "<input type='checkbox' name='choice' value='#{index}'>#{choice}<br>"
            }.join}
            <br />
            <input type="submit" value="投票">
            <input type="reset" value="選択解除">
          </form>
          <br />
          <a href="https://cgi.u.tsukuba.ac.jp/~s2313911/wp/view_result.rb">投票結果を見る</a>
        </body>
      </html>
    HTML
  end
rescue Exception => e
  # 例外をキャッチ Errorの具体的な内容を非表示にしてXSSに備える
  cgi.out("type" => "text/html", "charset" => "UTF-8") do
    <<-HTML
      <html>
        <body>
          <p>Error: #{CGI.escapeHTML(e.message)}</p>
        </body>
      </html>
    HTML
  end
end