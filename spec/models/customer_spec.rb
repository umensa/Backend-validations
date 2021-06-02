require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:subject) {
    Customer.create(
      first_name: "Jack",
      last_name: "Smith",
      phone: "8889995678",
      email: "jsmith@sample.com"
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a first_name" do
    expect(subject.first_name = "").to be_empty
    expect(subject).to_not be_valid

    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a last_name" do
    expect(subject.last_name = "").to be_empty
    expect(subject).to_not be_valid

    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a phone number" do
    expect(subject.phone = "").to be_empty
    expect(subject).to_not be_valid

    subject.phone = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an email" do
    expect(subject.email ="").to be_empty
    expect(subject).to_not be_valid

    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid if the phone number is not 10 chars" do
    expect(subject.phone.length).to equal(10)

    subject.phone = "123456789"
    expect(subject).to_not be_valid

    subject.phone = "12345678901"
    expect(subject).to_not be_valid
  end

  it "is not valid if the phone number is not all digits" do
    expect(subject.phone).to match(/\A[+-]?\d+\z/)

    subject.phone = "phone"
    expect(subject).to_not be_valid
  end

  it "is not valid if the email address doesn't have a @" do
    expect(subject.email).to include("@")
    
    subject.email = "email at example.com"
    expect(subject).to_not be_valid
  end

  it "returns the correct full_name" do
    expect(subject.full_name).to eq("Jack Smith")
  end
end
