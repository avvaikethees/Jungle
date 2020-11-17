require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    let(:category) { Category.new( name: "TestCategory" ) }
    let(:product) { Product.new( 
      name: "TestProduct", 
      description: 'TestDescription', 
      category_id: category.id, 
      quantity: 50, 
      price_cents: 1000 ) }

    context 'to save a new product' do 
      it 'saves with all required fields inputted correctly' do 
        category.save
        product.save
        expect(product).to be_valid
      end

      it 'does not save if name field is not inputted' do
        category.save
        product.name = nil
        product.save
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include("Name can't be blank")
      end

      it 'does nto save if price field is not inputted' do
        category.save
        product.price_cents = nil
        product.save
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include("Price can't be blank")
      end

      it 'does not save if  quantity field is not inputted' do
        category.save
        product.quantity = nil
        product.save
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include("Quantity can't be blank")
      end

      it 'does not save if category id is not inputted' do
        category.save
        product.category_id = nil
        product.save
        expect(product).not_to be_valid
        expect(product.errors.full_messages).to include("Category can't be blank")
      end
    end
  end
end


