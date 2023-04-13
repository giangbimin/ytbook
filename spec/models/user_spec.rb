require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: 'test@example.com', password: 'password') }

  context 'validations' do
    it { should have_secure_password }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('user').for(:email) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(20) }
  
    it 'is not valid with a duplicate email' do
      User.create(email: 'test@example.com', password: 'password')
      expect(subject).to_not be_valid
    end
  end

  describe 'before_validation callback' do
    it 'downcases email before validation' do
      subject.email = 'TEST@EXAMPLE.COM'
      subject.valid?
      expect(subject.email).to eq('test@example.com')
    end
  end
end
