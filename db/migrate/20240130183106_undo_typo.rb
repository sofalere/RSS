class UndoTypo < ActiveRecord::Migration[7.1]
  def change
    remove_column :articles, :pud_date
  end
end
