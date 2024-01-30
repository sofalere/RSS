class RssDataFetcher
  API_URL = "https://rss.slashdot.org/Slashdot/slashdotMain"

  def self.fetch_and_save
    response = fetch_data
    parsed_data = parse_XML(response)
    save_articles(parsed_data)
  end

  private

  def self.fetch_data
    URI.open(API_URL)
  end

  def self.parse_XML(response)
    doc = Nokogiri::XML(response, nil, 'EUC-JP')
    articles = []

    doc.remove_namespaces!
    doc.xpath('//item').each do |item|
      item = {
        'title'       => item.at('./title').text,
        'link'        => item.at('./link').text,
        'description' => item.at('./description').text,
        'pub_date'    => item.at('./date').text
      }
  
      item['description'] = item['description'].split('<p>', 2).first if item['description']
      articles << item
    end
    
    articles
  end

  def self.save_articles(articles)
    new_links = articles.map { |article| article['link'] }
    existing_links = Article.where(link: new_links).pluck(:link)

    new_articles = articles.select { |article| !existing_links.include?(article['link']) }
    Article.insert_all(new_articles)
  end

  # def save_articles(articles)
  #   articles.each { |article| 
  #     begin 
  #       Article.create(article) 
  #     rescue ActiveRecord::RecordNotUnique => e
  #       p "Article already saved"
  #     end
  #   }
  # end
end
