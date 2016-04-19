class NotificationsWorker
  include Sidekiq::Worker
  
  def perform livestream_id
    Livestream.find(livestream_id).notify
  end
end