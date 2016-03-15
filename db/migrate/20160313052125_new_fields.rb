class NewFields < ActiveRecord::Migration
  def change
    change_table :banks do |t|
      t.string :code
      t.string :name
    end
    change_table :products do |t|
      t.string :code
      t.string :name
      t.string :description
    end
    change_table :restrictions do |t|
      t.string :name
      t.string :value
      t.string :type
    end
  end
end
