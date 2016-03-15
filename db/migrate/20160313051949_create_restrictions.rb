class CreateRestrictions < ActiveRecord::Migration
  def change
    create_table :restrictions do |t|

      t.timestamps null: false
    end
  end
end
