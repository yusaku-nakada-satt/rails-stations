# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# wheneverはバックグラウンドで処理されるものであるため、Railsとは関係のないプロセスだから
# このファイルの中でRailsのメソッドを使いたい場合は下記の記述が必要である。
# つまりconfig/environment.rbを読み込んでいる
require File.expand_path("#{File.dirname(__FILE__)}/environment")

# ENV['RAILS_ENV']で環境を判断し、何も入っていなければ入っていなければ：developmentをrails_envに代入
rails_env = ENV['RAILS_ENV'] || :development

# cronを実行する環境変数をセット
set :environment, rails_env

# レビュー用に10分ごとの実行を設定
# every 10.minutes do
#   rake 'movie_ranking:update_ranking'
# rescue StandardError => e
#   Rails.logger.error "Error: #{e.message}"
# end

# トップページのランキング更新バッチ
# 要件に合わせてJST 0時に実行するように設定
every 1.day, at: '0:00' do
  rake 'movie_ranking:update_ranking'
rescue StandardError => e
  Rails.logger.error "Error: #{e.message}"
end

# リマインドメール送信バッチ
# 要件に合わせてJST 19時に実行するように設定
every 1.day, at: '19:00' do
  rake 'reservation_remind:email_remind'
rescue StandardError => e
  Rails.logger.error "Error: #{e.message}"
end

# Learn more: http://github.com/javan/whenever
