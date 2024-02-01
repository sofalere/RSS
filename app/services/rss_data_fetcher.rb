require 'open-uri'

class RssDataFetcher
  RSS_URL = "https://rss.slashdot.org/Slashdot/slashdotMain"

  def self.run
    URI.open(RSS_URL)
  end
end
