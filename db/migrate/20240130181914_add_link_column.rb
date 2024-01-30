class AddLinkColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :link, :string, null: false
    add_index :articles, :link, unique: true
  end
end
