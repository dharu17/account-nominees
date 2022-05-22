# frozen_string_literal: true

# Account class
class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]
  before_action :set_nominee, only: %i[edit_nominee update_nominee remove_nominee]

  def add_nominee
    return unless params[:nominee].present?
    nominee_account = Account.find_or_create_default_account(params[:nominee][:email])
    nominee = current_account.nominees.find_by(nominee_id: nominee_account.id)
    nominee = if nominee.present?
                nominee.update(nominee_params)
              else
                current_account.nominees.create(nominee_id: nominee_account.id, weightage: params[:nominee][:weightage])
              end
    return unless nominee.errors.present?
    redirect_to add_nominee_account_path(current_account.id), notice: nominee.errors.full_messages.join.to_s
  end

  def edit_nominee; end

  def update_nominee
    if @nominee.update(nominee_params)
      redirect_to add_nominee_account_path(current_account.id)
    else
      render 'edit_nominee', notice: @nominee.errors.full_messages.join.to_s
    end
  end

  def remove_nominee
    @nominee.destroy
    redirect_to add_nominee_account_path(current_account.id), notice: 'Nominee deleted successfully'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find_by(id: params[:id])
  end

  def set_nominee
    @nominee = Nominee.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:username, :first_name, :last_name, :email)
  end

  def nominee_params
    params.require(:nominee).permit(:email, :weightage)
  end
end
