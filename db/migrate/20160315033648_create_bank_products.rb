class CreateBankProducts < ActiveRecord::Migration
  def change
    create_table :bank_products do |t|
      t.timestamps null: false
    end
  end
end
