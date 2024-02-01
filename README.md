## Welcome to the Rails RSS Feed App!

### Getting Started

#### Ruby Version

Ensure you have Ruby v3.0 or later installed.

#### Clone the Repository

```bash
git clone https://github.com/sofalere/RSS.git
```

#### Open Root

```bash
cd RSS
```

#### Install Dependencies

```bash
bundle install
```

#### Ensure Database Schema is Up to Date

```bash
rails db:migrate
```

#### Run Rails Server

```bash
rails s
```

#### View App

http://localhost:3000/

***

The below 3 steps are optional and are for offline data fetching (explained more in below section):

#### Install Redis

https://redis.io/docs/install/install-redis/

#### Start Redis (on Mac)

```bash
brew services start redis
```
- run in any other terminal
  
#### Start Sdiekiq

```bash
bundle exec sidekiq
```
- run in another terminal but make sure its from the apps root directory

***

### Testing
`rails test`

# Features:

### Fetches data from RSS feed URL 
"/app/services/rss_data_fetcher.rb"

`RssDataFetcher.run() -> File instance`
- the provided RSS_URL saved as constant 

### Parses XML data
"/app/services/xml_data_parser.rb"

`XmlDataParser.run(fileInstance) -> [{title:, link:, description:, pub_date:}]`

### Saves unique articles
"app/services/article_saver.rb"

`ArticleSaver.run( [{}, {}...] )`
- An article is considered unique if it has a source link
that doesn't already exist in the database.
- MAX_ARTICLES constant hold value 100, 
	so there should never be more than 115 articles

### Fetches data while offline and saves in db
"app/jobs/fetch_data_scheduler.rb"
- Every 14 hours a sidekiq job runs to fetch new data (via the same service calls as when loading a new page) 
so the user doesn't miss any interesting articles while not logged in.

Why 14 hours?
- Assuming SRR data stays consistent, the URL returns 15 articles each time,
a new one is created every hour and takes the place of the oldest.

### Runs db cleanup
The repeating job could overwhelm the db if not maintained.
"app/jobs/article_cleanup_scheduler.rb"
- Runs every 2 days and deletes any articles if there are more than 100, also
starting from the oldest. 


### User can mark articles as read or unread
"app/javascript/controllers/article.js"
- When toggled, the click fires an XHR. 
- It changes the text next to the
checkbox from `Mark Read` to `Mark Unread`. 
- Within the update action, in the 
controller, the articles model is found and the read attribute is updated.

