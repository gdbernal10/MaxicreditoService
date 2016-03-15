class BankProduct < ActiveRecord::Base
  validates_uniqueness_of :bank_id, :scope => :product_id
  belongs_to :bank
  belongs_to :product
end
