class Relations3 < ActiveRecord::Migration
  def change
    remove_foreign_key :restrictions, :products
    remove_reference :restrictions, :product, index: true
  end
end
