class AddNotNullConstraints < ActiveRecord::Migration[7.1]
  def change
    change_column :articles, :title, :string, null: false

    change_column :articles, :description, :text, null: false

    change_column :articles, :pud_date, :datetime, null: false
  end
end
