class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.datetime :pub_date
      t.boolean :read

      t.timestamps
    end
  end
end
