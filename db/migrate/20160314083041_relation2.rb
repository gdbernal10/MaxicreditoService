class Relation2 < ActiveRecord::Migration
  def change
    remove_column :restrictions, :product_id
    change_table :restrictions do |t|
      t.belongs_to :product, index: true, foreign_key: true
    end
  end
end
