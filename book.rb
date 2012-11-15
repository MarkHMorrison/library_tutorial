class Book
	attr_accessor :title, :author, :category, :status
	def initialize title, author, category
		@title = title
		@author = author
		@category = category
		@status = :available
	end

	def checkout
		if @status == :available 
			@status = :on_loan
		else
			raise 'Book is already checked out'
		end
	end

	def checkin
		if @status == :on_loan
			@status = :available
		else
			raise 'Book is not checked out'
		end
	end

	def lost
		@status = :lost
	end
end
