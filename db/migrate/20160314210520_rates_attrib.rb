class RatesAttrib < ActiveRecord::Migration
  def change
    change_column :rates, :value, :decimal, :precision => 5, :scale => 2
  end
end
