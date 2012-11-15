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

	describe "#checkout" do
		context "when book is available" do
			it "changes status to loaned" do
				@book.status.should eql :available
				@book.checkout
				@book.status.should eql :on_loan
			end
		end
		context "when book is not available" do
			it "raises an error" do
				@book.checkout
				@book.status.should eql :on_loan
				lambda { @book.checkout }.should raise_error
			end
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
	

end