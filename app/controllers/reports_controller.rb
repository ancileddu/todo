class ReportsController < ApplicationController
	before_action :authenticate_user!, :set_task

	def index 
		#@tasks = Task.all
	end
	
	def view


    #respond_to do |format|
     # format.pdf do
        render pdf: "Report",
               :template => 'reports/view.pdf.erb', formats: :html, encoding: 'utf8',
               locals: {:task => @task}
      #end
    #end
  end

private
def set_task
  @tasks = Task.all
end


end
