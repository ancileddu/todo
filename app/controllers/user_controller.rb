class UserController < ApplicationController
	def index
      if request.xhr?
  		# respond to Ajax request
 		 @username = User.all.collect(&:username)
     	 respond_to do |format|
        	format.json { render :json => @username }
     				 end
		else
  		# respond to normal request
  		redirect_to tasks_path #the root
		end

    end

    def show
    if request.xhr?
      render :json => current_user 
    else
      # respond to normal request
      redirect_to tasks_path #the root
    end

  end
end
