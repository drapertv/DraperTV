class VisitorsController < ApplicationController

	def home
		@login_failure = params[:message] == "login_failure"
	end

end
