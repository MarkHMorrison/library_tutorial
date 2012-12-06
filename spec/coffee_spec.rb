require 'spec_helper'

describe Coffee do

	before :each do
		@coffee = Coffee.new
	end

	describe "#new" do

		it "returns a Coffee object" do
			@coffee.should be_an_instance_of Coffee
		end

		it "has a cost of 2" do
			@coffee.cost.should eql 2
		end

		it "has an origin of Colombia" do
			@coffee.origin.should eql "Colombia"
		end

		it "has an ingredients array of coffee water" do
			@coffee.ingredients.should eql ["coffee", "water"]
		end

	end

	describe "with Milk" do

		before :each do
			@coffeeMilk = Milk.new @coffee
		end

		it "has a cost of 2.4" do
			@coffeeMilk.cost.should eql 2.4
		end

		it "has an origin of Colombian Cows" do
			@coffeeMilk.origin.should eql "Colombian Cows"
		end

	end

	describe "with Sugar" do

		before :each do
			@coffeeSugar = Sugar.new @coffee
		end

		it "has a cost of 2.2" do
			@coffeeSugar.cost.should eql 2.2
		end

		it "has an origin of Colombia" do
			@coffeeSugar.origin.should eql "Colombia"
		end

	end

	describe "Double" do

		before :each do
			@coffeeDoubled = Double.new @coffee
		end

		it "has a cost of 4" do
			@coffeeDoubled.cost.should eql 4
		end

		it "has an origin of Colombia" do
			@coffeeDoubled.origin.should eql "Colombia"
		end

	end

	describe "Latte" do

		before :each do
			@coffeeLatte = Latte.new @coffee
		end

		it "has a cost of 3.4" do
			@coffeeLatte.cost.should eql 3.4
		end

		it "has an origin of Colombian Cows with Mexican Vanilla Beans" do
			@coffeeLatte.origin.should eql "Colombian Cows with Mexican Vanilla Beans"
		end

		it "has an ingredients array of coffee water milk whipped cream vanilla" do
			@coffeeLatte.ingredients.should eql ["coffee", "water", "milk", "whipped cream", "vanilla"]
		end

	end

end
