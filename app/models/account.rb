# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true
  validates_uniqueness_of :email
  has_many :nominees, class_name: 'Nominee', dependent: :destroy, foreign_key: 'account_id'
  has_many :nominee_users, through: :nominees, source: :nominee
  has_many :nominators, class_name: 'Nominee', dependent: :destroy, foreign_key: 'nominee_id'
  has_many :nominated_by, through: :nominators, source: :account

  def self.find_or_create_default_account(email)
    Account.find_by_email(email) || Account.create(email: email, password: 'Test@123')
  end
end
