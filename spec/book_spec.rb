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

		context "when book is available" do
			it { @book.status.should eql :on_loan } 
		end
		context "when book is not available" do
			it { lambda { @book.checkout }.should raise_error }
		end
	end

	describe "#checkin" do
		context "when book is on loan" do
			it "changes status to available" do
				@book.checkout
				@book.status.should eql :on_loan
				@book.checkin
				@book.status.should eql :available
			end
		end
		context "when book is available" do
			it "raises an error" do
				@book.status.should eql :available	
				lambda { @book.checkin }.should raise_error
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

	describe "placeing a book on hold" do
		before :each do
			@book.hold
		end

		context "the book is available" do
			it "should change status to on hold" do
				@book.status.should == :on_hold
			end
		end
	end

	describe "when removing a book from hold" do
		before :each do
			@book.hold
			@book.release
		end

		context "the book is on hold" do
			it "should change status to available" do
				@book.status.should == :available
			end
		end
	end

end