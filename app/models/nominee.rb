# frozen_string_literal: true

class Nominee < ApplicationRecord
  belongs_to :nominee, class_name: 'Account'
  belongs_to :account, class_name: 'Account'
  validates_uniqueness_of :nominee_id, scope: :account
  validate :nominee_id_cannot_be_account
  validate :valid_weightage_percentage?
  MAX_WEIGHTAGE = 100

  private

  # validation for nominee and account can't be same.
  def nominee_id_cannot_be_account
    errors.add(:nominee_id, "can't add yourself as nominee") if nominee_id == account_id
  end

  # check valid weightage percentage
  def valid_weightage_percentage?
    total_weight = (account.nominees.sum(&:weightage).to_f + weightage.to_f) if account&.nominees.present?
    return unless total_weight.present? && (total_weight > MAX_WEIGHTAGE)

    errors.add(:weightage, "Summation of weightage of all nominees shouldn't be > 100")
  end
end
