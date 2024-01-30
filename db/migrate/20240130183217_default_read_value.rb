class DefaultReadValue < ActiveRecord::Migration[7.1]
  def change
    change_column_default :articles, :read, false
  end
end
