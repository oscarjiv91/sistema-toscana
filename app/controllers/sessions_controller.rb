class SessionsController < ApplicationController
	skip_before_filter :logged_in?
	
	def new
	end

	def destroy
		sign_out
		redirect_to signin_path
	end

	def create
		user = User.find_by(username: params[:session][:username].downcase)
		 if user && user.authenticate(params[:session][:password])
		    # Sign the user in and redirect to the user's show page.
		    sign_in user
		    redirect_to root_url
		 else
		    # Create an error message and re-render the signin form.
		    flash[:error] = 'Invalid email/password combination' # Not quite right!
		    render 'new'
		 end
	end
end
