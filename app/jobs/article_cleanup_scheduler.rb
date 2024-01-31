class ArticleCleanupScheduler 
  include Sidekiq::Worker

  def perform
    ArticleCleanup.run
    puts "Articles in db cleaned up via scheduler"
  end
end