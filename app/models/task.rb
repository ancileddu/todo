class Task < ActiveRecord::Base
	belongs_to :user

	scope :closed, -> {
  where(:completed => true)
}

	scope :opened, -> {
  where(:completed => false)
}
scope :category_list, -> {
	Task.select(:category).distinct
}
	


def self.notify(username)
	Task.where(assignee: username).where(notified: false).count
end

def self.notified(username)
	Task.where(assignee: username).where(notified: false).update_all notified: true
end

def self.rating
	((closed.count.to_f/count.to_f)*100).round(1)
end



def count_task_categories(category)
	Task.where(category: category).count
	
end

def completed_categories(category)
	(Task.where(category: category).closed.count.to_f/count_task_categories(category).to_f)*100

end


end
