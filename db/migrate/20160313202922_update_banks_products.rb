class UpdateBanksProducts < ActiveRecord::Migration
  def change
    change_table :banks do |t|
      t.string :nit
    end
  end
end
