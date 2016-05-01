class ScannerRatesChanges < ActiveRecord::Migration
  def change
    change_table :scanners do |t|
      t.string :rates_to_scan
    end
  end
end
