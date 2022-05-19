class HomeController < ApplicationController
	def index
		if current_account.present?
			@nominees = current_account.nominee_users 
			@nominated_by = current_account.nominated_by
		end
	end
end
