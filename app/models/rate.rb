class Rate < ActiveRecord::Base
    belongs_to :product
    belongs_to :bank
end
