class CreateScanners < ActiveRecord::Migration
  def change
    create_table :scanners do |t|
        t.integer :salary
        t.integer :term
        t.decimal :amount
        t.boolean :employee
        t.boolean :active
        t.boolean :tn_email
        t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
