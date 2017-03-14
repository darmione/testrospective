class Dog
	def initialize(name, owner, bites, dog_years)
  	@name = name
  	@owner = owner
  	@bites = bites
  	@dog_years = dog_years #=> human years
	end

	def name
		@name
	end

	def owner
		@owner
	end

	def owner=(other)
		@owner = other
	end

	def dog_years
		@dog_years
	end

	def dog_years=(other)
		@dog_years = other
	end

	def bites?
		@bites
	end

	def bark
		"Bark! Bark!"
	end

	def bark!
		@bites = true
		"Bark! Bark!"
	end

	def to_human_years
  	@dog_years / 7
	end

	def ==(other)
		@name == other.name &&
		@owner == other.owner &&
		@dog_years == other.dog_years
	end

	def same_owner?(loxy)
		@owner == loxy.owner
	end
end
