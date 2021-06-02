class Order < ApplicationRecord
  validates :product_name, presence: true
  validates :product_count, presence: true
  validates :product_count, numericality: { only_integer: true, greater_than: 0 }
  validates :customer, presence: true
  validates_associated :customer

  belongs_to :customer
end
