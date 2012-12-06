class Coffee
	def cost
		2
	end

	def origin
		"Colombia"
	end

	def ingredients
		["coffee", "water"]
	end
end

class Milk
	def initialize(coffee)
		@coffee = coffee
	end

	def cost
		@coffee.cost + 0.4
	end

	def origin
		@coffee.origin + "n Cows"
	end
end

module Decorator
	def initialize(coffee)
		@coffee = coffee
	end

	def method_missing(method, *args)
		if @coffee.respond_to?(method)
			@coffee.send(method, *args)
		else
			super
		end
	end

	# def respond_to?(method)
	# 	@coffee.respond_to?(method)
	# end

	def respond_to_missing?(method, include_private = false)
		super
	end


end

class Sugar
	include Decorator

	def cost
		@coffee.cost + 0.2
	end

end


class CoffeeDecorator
	extend Forwardable

	def initialize(coffee)
		@coffee = coffee
	end

end

class Double < CoffeeDecorator
	def_delegators :@coffee, :origin, :ingredients

	def cost
		@coffee.cost * 2
	end

end

class Latte < CoffeeDecorator
	def_delegators :@coffee

	def cost
		Milk.new(@coffee).cost + 1.00
	end

	def origin
		Milk.new(@coffee).origin + " with Mexican Vanilla Beans"
	end

	def ingredients
		@coffee.ingredients << "milk" << "whipped cream" << "vanilla"
	end

end

