# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should have_many(:nominees).class_name('Nominee').dependent(:destroy).with_foreign_key('account_id') }
  it { should have_many(:nominee_users).through(:nominees) }
  it { should have_many(:nominators).class_name('Nominee').dependent(:destroy).with_foreign_key('nominee_id') }
  it { should have_many(:nominated_by).through(:nominators) }
end
