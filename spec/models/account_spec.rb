require 'rails_helper'

RSpec.describe Account, type: :model do
    it { should validate_presence_of(:email) }
  	it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
	it { should have_many(:nominees).class_name('Nominee').dependent(:destroy)}
    # it { should have_many(:nominee_accounts).through(:nominees) }
end
