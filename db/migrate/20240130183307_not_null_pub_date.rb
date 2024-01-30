class NotNullPubDate < ActiveRecord::Migration[7.1]
  def change
    change_column :articles, :pub_date, :datetime, null: false

  end
end
