class Article < ApplicationRecord
  validates :title, presence: true
  validates :link, presence: true, uniqueness: true
  validates :description, presence: true
  validates :pub_date, presence: true

  def toggle_read_status
    update(read: !read)
  end
end
