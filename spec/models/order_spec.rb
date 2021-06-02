require 'rails_helper'

RSpec.describe Order, type: :model do

  # customer = FactoryBot.create(:customer)
  # let (:subject) {
  #     Order.new(
  #     product_name: "cookies",
  #     product_count: 5,
  #     customer_id: customer.id
  #     )
  #   }
  subject { Order.new( product_name: "gears", product_count: 7, customer: FactoryBot.create(:customer))}
  
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a product_name" do
    expect(subject.product_name = "").to be_empty
    expect(subject).to_not be_valid 

    subject.product_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a product_count" do
    expect(subject.product_count = "").to be_empty
    expect(subject).to_not be_valid

    subject.product_count = 0
    expect(subject).to_not be_valid
    
    subject.product_count = nil
    expect(subject).to_not be_valid
  end
end
