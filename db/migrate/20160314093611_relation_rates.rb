class RelationRates < ActiveRecord::Migration
  def change
    change_table :rates do |t|
      t.belongs_to :bank, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key:true
    end
  end
end
