class Book
	attr_accessor :title, :author, :category, :status, :due_on, :patrons_waiting, :fine
	def initialize title, author, category
		@title = title
		@author = author
		@category = category
		@status = :available
		@due_on = nil
		@patrons_waiting = 0
		@fine = 0
	end

	def checkout
		if @status == :available 
			@status = :on_loan
			@due_on = Date.today + 14
		else
			raise 'Book is already checked out'
		end
	end

	def checkin
		if @status == :on_loan
			if patrons_waiting?
				@patrons_waiting -= 1
				@status = :on_hold
			else
				@status = :available
			end

			if @due_on < Date.today
				@fine = Date.today - @due_on
			end
		else
			raise 'Book is not checked out'
		end
	end

	def lost
		@status = :lost
	end

	def available?
		@status == :available
	end

	def hold
		if @status == :available
			@status = :on_hold
		elsif @status == :on_loan
			@patrons_waiting += 1
		end
	end

	def on_hold?
		@status == :on_hold
	end

	def patrons_waiting?
		@patrons_waiting > 0
	end

	def has_fine?
		@fine > 0
	end

	def overdue?
		@due_on < Date.today
	end
end
