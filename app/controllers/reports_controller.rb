class ReportsController < ApplicationController
	before_action :authenticate_user!, :set_task

	def index 
	end
	
	def view
	    render pdf: "Report",
	           :template => 'reports/view.pdf.erb', formats: :html, encoding: 'utf8',
	           locals: {:task => @task}
  	end

	private
	def set_task
	  @tasks = Task.all
	end


end
