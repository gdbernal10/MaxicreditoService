class Bank < ActiveRecord::Base
  validates_uniqueness_of :code
  has_many :rates
  has_many :bank_products
  has_many :products, through: :bank_products
  has_many :restrictions, through: :products
end
