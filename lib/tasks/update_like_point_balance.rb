class Tasks::UpdateLikePointBalance
  class << self
    def run
      update_like_point_balance
    end

    def update_like_point_balance
      LikePoint.all.each do |point|
        point.update(balance: 10)
        output_log(point)
      end
    end

    def output_log(point)
      log = 'log/cron.log'
      logger = Logger.new(log, 5, 10.megabytes)

      logger.info(<<-LOG
        [#{Time.current}] Notify update like_point balance
        #{point.user.email}
      LOG
                 )
    end
  end
end
