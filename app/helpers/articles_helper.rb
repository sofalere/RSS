module ArticlesHelper
  def preview(description)
    truncate(description, length: 450, separator: '...')
  end
end
