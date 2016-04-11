class ProductSelf < ActiveRecord::Migration
  def change
    change_table :products do |p|
      p.belongs_to :product, index: true, foreign_key: true
    end
  end
end
