require 'rails_helper'

module Identity
  RSpec.describe UserFollow, type: :model do
    it { should validate_presence_of(:requester_id) }
    it { should validate_presence_of(:addressee_id) }
    it { should belong_to(:requester).with_foreign_key('requester_id').class_name('User') }
    it { should belong_to(:addressee).with_foreign_key('addressee_id').class_name('User') }
  end
end
