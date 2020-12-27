require 'rails_helper'

module Identity
  RSpec.describe User, type: :model do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should have_many(:requesters).with_foreign_key('requester_id').class_name('UserFollow') }
    it { should have_many(:addressees).with_foreign_key('addressee_id').class_name('UserFollow') }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
end
