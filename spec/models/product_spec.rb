require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should create a product if all of the validations are true' do
    @category = Category.new(name: "Testing")
    @product = Product.new(name: "Supreme Nas Tee", price_cents: 3500, quantity: 35, :category => @category)
    @product.valid?
    expect(@product.errors).not_to include("can\'t be blank")
    end
    it 'should not create a product if the name is missing' do
    @category = Category.new(name: "Testing")
    @product = Product.new(price_cents: 3500, quantity: 35, :category => @category)
    @product.valid?
    expect(@product.errors[:name]).to include("can\'t be blank")
    end
    it 'should not create a product if the quantity is missing' do
    @category = Category.new(name: "Testing")
    @product = Product.new(name: "Supreme Nas Tee", price_cents: 3500, :category => @category)
    @product.valid?
    expect(@product.errors[:quantity]).to include("can\'t be blank")
    end
    it 'should not create a product if the price is missing' do
    @category = Category.new(name: "Testing")
    @product = Product.new(name: "Supreme Nas Tee", quantity: 35, :category => @category)
    @product.valid?
    expect(@product.errors[:price]).to include("can\'t be blank")
    end
    it 'should not create a product if the category is missing' do
    @category = Category.new(name: "Testing")
    @product = Product.new(name: "Supreme Nas Tee", price_cents: 3500, quantity: 35)
    @product.valid?
    expect(@product.errors[:category]).to include("can\'t be blank")
    end
  end
end
