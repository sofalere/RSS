class FetchDataScheduler 
  include Sidekiq::Worker

  def perform
    puts "New data fetched and saved via scheduler"
    RssDataFetcher.fetch_and_save
  end
end