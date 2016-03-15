class NewFields2 < ActiveRecord::Migration
  def change
    #change_table :products do |t|
    #  t.integer :restriction_id
    #end
    add_reference :products, :restriction, index: true, foreign_key: true
    change_table :rates do |t|
      t.integer :minMonths
      t.integer :maxMonths
      t.decimal :value
    end
    add_reference :rates, :bank, index: true, foreign_key: true
    add_reference :rates, :product, index: true, foreign_key: true
    change_table :restrictions do |t|
      t.integer :minSalary
      t.boolean :employee
      t.integer :mesesemployee
    end
    remove_column :restrictions, :name, :string
    remove_column :restrictions, :value, :string
    remove_column :restrictions, :type, :string
  end
end
