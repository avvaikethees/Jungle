require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new( 
    first_name: "TestFirstName", 
    last_name: 'TestLastName', 
    email: "test@email.com", 
    password: "password123",
    password_confirmation: "password123" ) }
  
    describe 'Validations' do
    context 'to register a user' do 
      it 'saves with all required fields inputted correctly' do 
        user.save
        expect(user).to be_valid
      end

      it 'does nto save if password field is empty' do 
        user.password = nil
        user.save
        expect(user).not_to be_valid
      end

      it 'does not save if password_confirmation is different than password' do
        user.password_confirmation = "password1234"
        user.save
        expect(user).not_to be_valid
      end

      it 'does not save if name field is empty' do 
        user.first_name = nil
        user.save
        expect(user).not_to be_valid
      end

      it 'does not save if name field is empty' do 
        user.last_name = nil
        user.save
        expect(user).not_to be_valid
      end

      it 'does not save if name field is empty' do 
        user.email = nil
        user.save
        expect(user).not_to be_valid
      end

      it "does not save if email is already in the system" do
        repeat_user = User.new(first_name: 'Test2', last_name: 'TestLast2', email: 'TEST@emaiL.cOm', password: 'password123', password_confirmation: 'password123')
        user.save
        repeat_user.save
        expect(repeat_user).not_to be_valid
      end

      it 'does not save when password is too short' do
        user.password = 'tes'
        user.password_confirmation = 'tes'
        user.save
        expect(user).not_to be_valid
      end
 
    end
  end

  describe '.authenticate_with_credentials' do 
    it 'returns a user instance for successful login - email and password exists' do
      user.save
      expect(User.authenticate_with_credentials(user.email, user.password)).to eq(user)
    end

    it 'returns null with invalid email or password' do
      user.save
      authentication = User.authenticate_with_credentials('blah@email.com', user.password)
      expect(authentication).to eq(nil)
      authentication = User.authenticate_with_credentials(user.email, 'wrongpassword')
      expect(authentication).to eq(nil)
    end

    it 'returns a user instance even extra whitespaces are typed' do
      user.save
      expect(User.authenticate_with_credentials('   test@email.com', user.password)).to eq(user)
      expect(User.authenticate_with_credentials('test@email.com   ', user.password)).to eq(user)
    end

    it 'returns a user instance even if visitor uses wrong casing for their email' do
      user.save
      expect(User.authenticate_with_credentials('Test@email.cOm', user.password)).to eq(user)
    end

  end
end


