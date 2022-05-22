# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  before(:each) do
    @account = FactoryBot.create(:account)
  end

  describe '#add_nominee' do
    context 'Add new valid nominee' do
      it 'should pass when the address is created successfully' do
        sign_in(@account)

        nominees_count = @account.nominee_users.count

        params = { nominee: { email: 'test@email.com', weightage: '20' }, id: @account.id }
        post :add_nominee, params: params

        expect(response.status).to eq(200)
        expect(@account.nominee_users.collect(&:email)).to have_content('test@email.com')
        expect(@account.nominee_users.count).to eq(nominees_count + 1)
      end

      it 'shouldnt create nominee when passed invalid weigtage params' do
        sign_in(@account)

        nominees_count = @account.nominee_users.count

        params = { nominee: { email: 'test1@email.com', weightage: '120' }, id: @account.id }
        post :add_nominee, params: params

        expect(response.status).to eq(200)
      end

      it 'shouldnt create nominee when passed invalid email params' do
        sign_in(@account)

        nominees_count = @account.nominee_users.count

        params = { nominee: { email: @account.email, weightage: '20' }, id: @account.id }
        post :add_nominee, params: params

        expect(response.status).to eq(302)

        expect(@account.nominee_users.count).to eq(nominees_count)
      end
    end

    context 'update nominee weightage' do
      it 'update nominee successfully' do
        sign_in(@account)

        email = 'test@email.com'
        weightage = '90.0'

        nominee = @account.nominees.create(nominee_id: @account.id, weightage: weightage)

        update_params = { nominee: { weightage: '20' }, id: @account.id }
        post :add_nominee, params: update_params

        expect(response.status).to eq(302)

        expect(weightage).to have_content(nominee.weightage)
      end

      it 'update nominee with invalid weightage' do
        sign_in(@account)

        email = 'test@email.com'
        weightage = '90.0'

        nominee = @account.nominees.create(nominee_id: @account.id, weightage: weightage)

        update_params = { nominee: { weightage: '90' }, id: @account.id }
        post :add_nominee, params: update_params

        expect(response.status).to eq(302)

        expect(weightage).to have_content(nominee.weightage)
      end
    end
  end
end
