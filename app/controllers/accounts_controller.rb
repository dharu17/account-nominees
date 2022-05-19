class AccountsController < ApplicationController
	before_action :set_account, only: %i[ show edit update destroy ]
	before_action :set_nominee, only: %i[ edit_nominee update_nominee remove_nominee ]

  def add_nominee
  	if params[:nominee].present?
      account = Account.find_or_create_default_account(params[:nominee][:email]) 
      if account.present?
        nominee = current_account.nominees.find_by(nominee_id: account.id)
        if nominee.present?
          nominee = nominee.update(weightage: params[:nominee][:weightage])
        else
          nominee = current_account.nominees.create(nominee_id: account.id, weightage: params[:nominee][:weightage])
        end
      end
      redirect_to add_nominee_account_path(current_account.id), notice: "#{nominee.errors.full_messages.join}" if nominee.errors.present?
		end
  end

  def edit_nominee
  end

  def update_nominee
  	if @nominee.update(weightage: params[:nominee][:weightage])
  		redirect_to add_nominee_account_path(current_account.id)
  	else
  		render 'edit_nominee'
  	end
  end

  def remove_nominee
  	@nominee.destroy
  	redirect_to add_nominee_account_path(current_account.id), notice: "Nominee deleted successfully"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find_by(id: params[:id])
    end

    def set_nominee
      @nominee = Nominee.find_by(id: params[:id])
    end

    # def valid_weightage_percentage?
    #   (100 - (current_account.nominees.pluck(:weightage).sum) >= params[:nominee][:weightage].to_f)
    # end

    # Only allow a list of trusted parameters through.
    def account_params
    	params.require(:account).permit(:username, :first_name, :last_name, :email)
    end
end
