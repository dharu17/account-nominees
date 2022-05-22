# frozen_string_literal: true

# spec/support/spec_test_helper.rb
module SpecTestHelper
  def sign_in(account)
    if account.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, { scope: :account })
      allow(controller).to receive(:current_account).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(account)
      allow(controller).to receive(:current_account).and_return(account)
    end
  end
end
