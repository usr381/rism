require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe '#name' do
    it { should validate_length_of(:name).is_at_least(1).is_at_most(100) }
    it { should validate_uniqueness_of(:name) }
  end

  describe '#full_name' do
    it { should validate_length_of(:full_name).is_at_least(0).is_at_most(200) }
    it { should validate_uniqueness_of(:full_name) }
  end

  describe '#parent_id' do
    it { should validate_numericality_of(:parent_id).only_integer }
  end

  it { should have_many(:users) }
  it { should have_many(:departments) }
  it { should have_many(:agreements) }
  it { should have_many(:contracts) }
  it { should have_many(:rights) }
  it { should have_many(:right_scopes) }
  it { should have_many(:children) }

  it { should belong_to(:parent) }
end