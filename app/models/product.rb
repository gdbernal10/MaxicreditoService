class Product < ActiveRecord::Base
  validates_uniqueness_of :code
  has_many :restrictions
  has_many :rates
end
