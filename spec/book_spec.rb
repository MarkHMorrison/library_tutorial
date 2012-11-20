require 'spec_helper'

describe Book do	
	before :each do
		@book = Book.new "Title", "Author", :category
	end

	describe "#new" do
		it "takes three parameters and returns a Book object" do
			@book.should be_an_instance_of Book
		end
	end

	describe "#title" do
		it "returns the correct title" do
			@book.title.should eql "Title"
		end
	end
	describe "#author" do
		it "returns the correct author" do
			@book.author.should eql "Author"
		end
	end
	describe "#category" do
		it "returns the correct category" do
			@book.category.should eql :category
		end
	end

	describe "checking out a book" do
		before :each do
			@book.checkout
		end

		context "when it is available" do
			it "changes status to loaned" do
				@book.status.should eql :on_loan
			end
		end
		it "is due 14 weeks from now" do
			@book.due_on.should == Date.today + 14
		end

		context "when book is not available" do
			it "raises an error" do
				lambda { @book.checkout }.should raise_error
			end
		end
	end

	describe "checking in a book" do
		context "when book is on loan" do
			before :each do
				@book.checkout
				@book.checkin
			end
			it "changes status to available" do
				@book.status.should eql :available
			end
		end
		context "when book is available" do
			before :each do
				@book.checkout
				@book.checkin
			end
			it "raises an error" do
				lambda { @book.checkin }.should raise_error
			end
		end
		context "when book has waiting patrons" do
			before :each do
				@book.checkout
				@book.hold
				@book.checkin
			end
			it { @book.should be_on_hold }
			it "should decrement the waiting list" do
				@book.patrons_waiting.should == 0
			end
		end
		context "when book is overdue" do
			before :each do
				@book.checkout
				@book.due_on = Date.today - 5
				@book.checkin
			end
			it { @book.should be_overdue }

			it "should have a fine" do
				@book.should have_fine
			end
			it "should have a fine amount of $1 per day" do
				@book.fine.should == 5
			end
		end
	end

	describe "placing a book on hold" do
		context "when book is available" do
			before :each do
				@book.hold
			end

			it { @book.should be_on_hold }

			it "should not increment the waiting list" do
				@book.patrons_waiting.should == 0
			end
		end

		context "when book is on loan" do
			before :each do
				@book.checkout
				@book.hold
			end

			it "should increment the waiting list" do
				@book.patrons_waiting.should == 1
			end
		end

	end
	
	describe "#lost" do
		it "changes status to lost" do
			@book.lost
			@book.status.should eql :lost
		end
	end

	describe "when a book is available" do
		it { @book.should be_available }
	end
end