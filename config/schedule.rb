# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = Rails.env.to_sym
rails_root = Rails.root.to_s
set :environment, rails_env
set :output, "#{rails_root}/log/cron.log"

every 1.day, at: '00:00 am' do
  runner 'Tasks::UpdateLikePointBalance.run'
end
