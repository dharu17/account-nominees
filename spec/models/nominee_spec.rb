require 'rails_helper'

RSpec.describe Nominee, type: :model do
  it { should belong_to(:nominee).class_name('Account') }
  it { should belong_to(:account).class_name('Account') }
  it { should validate_uniqueness_of(:nominee_id).scoped_to(:account) }
end
