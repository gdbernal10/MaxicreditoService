class Relations < ActiveRecord::Migration
  def change
    remove_foreign_key :products, :restrictions
    remove_reference :products, :restriction, index: true
    remove_foreign_key :rates, :banks
    remove_reference :rates, :bank, index: true
    remove_foreign_key :rates, :products
    remove_reference :rates, :product, index: true
    change_table :restrictions do |t|
      t.belongs_to :product, index: true
    end
  end
end
