class Relation4 < ActiveRecord::Migration
  def change
    change_table :restrictions do |t|
      t.belongs_to :product, index: true, foreign_key: true
    end
  end
end
