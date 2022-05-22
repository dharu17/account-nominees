# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let!(:account) { FactoryBot.create(:account) }

  describe '#index' do
    it 'it should load the page' do
      sign_in(account)
      expect(response.status).to eq(200)
    end
  end
end
