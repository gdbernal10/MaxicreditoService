class User < ActiveRecord::Base
  validates_uniqueness_of :email
  #has_many :scanners
end
