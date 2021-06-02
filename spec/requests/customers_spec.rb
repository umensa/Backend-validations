require 'rails_helper'

RSpec.describe "CustomersControllers", type: :request do

  describe "get customers_path" do
    it "renders the index view" do
      FactoryBot.create_list(:customer, 10)
      get customers_path
      expect(response).to render_template(:index)
    end
  end

  describe "get customer_path" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      get customer_path(id: customer.id)
      expect(response).to render_template(:show)
    end

    it "redirects to the index path if the customer id is invalid" do
      get customer_path(id: 5000) #an ID that doesn't exist
      expect(response).to redirect_to customers_path
    end
  end

  describe "get new_customer_path" do
    it "renders the :new template" do 
      get "/customers/new"
      expect(response).to render_template(:new)

      # customer = FactoryBot.create(:customer)
      # get new_customer_path(id: customer.id)
      # expect(response).to render_template(:new)
    end
  end

  describe"get edit_customer_path" do
    it "render the :edit template" do
      customer = FactoryBot.create(:customer)
      get edit_customer_path(id: customer.id)
      expect(response).to render_template(:edit)
    end
  end

  describe "post customers_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      expect { post customers_path, params: {customer: customer_attributes} }.to change(Customer, :count)
      expect(response).to redirect_to customer_path(id: Customer.last.id)
    end
  end

  describe "post customers_path with invalid data" do
    it "does not save a new entry or redirect" do
      customer_attributes = FactoryBot.attributes_for(:customer)
      customer_attributes.delete(:first_name)
      expect { post customers_path, params: {customer: customer_attributes} }.to_not change(Customer, :count)
      expect(response).to render_template(:new)
    end
  end

  describe "put customer_path with valid data" do

    it "updates an entry and redirects to the show path for the customer" do
      customer = FactoryBot.create(:customer, first_name: "John")
      expect(customer.first_name).to eql("John")
      expect(put customer_path(customer.id), params: {customer: {first_name: "Foulena"}}).to redirect_to customer_path(customer.id)

      put customer_path(customer.id), params: {customer: {first_name: "Kate"}}
      customer.reload
      expect(customer.first_name).to eql("Kate")
      expect(response).to redirect_to customer_path(customer.id)
    end
  end

  describe "put customer_path with invalid data" do
    it "does not update the customer record or redirect" do
      customer = FactoryBot.create(:customer)
      expect(put customer_path(customer.id), params: {customer: {phone: "123"}}).to render_template(:edit)

      put customer_path(customer.id), params: {customer: {last_name: ""}}
      customer.reload
      expect(customer.last_name).to_not be_empty
      expect(response).to render_template(:edit)
    end
  end

  describe "delete a customer record" do
    it "delete a customer record" do
      customer = FactoryBot.create(:customer)
      expect do 
        delete customer_path(customer.id)
      end.to change{Customer.count} # do .. end alternative to the {}
      expect(response).to redirect_to customers_path
      end
  end

  describe "GET /customers" do
    it "works! (now write some real specs)" do
      get customers_path
      expect(response).to have_http_status(200)
    end
  end
end
