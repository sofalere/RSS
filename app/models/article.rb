class Article < ApplicationRecord
  def toggle_read_status
    update(read: !read)
  end
end
