class FetchDataScheduler 
  include Sidekiq::Worker

  def perform
    response = RssDataFetcher.run
    parsed_data = XmlDataParser.run(response)
    ArticleSaver.run(parsed_data)

    puts "New data fetched and saved via scheduler"
  end
end