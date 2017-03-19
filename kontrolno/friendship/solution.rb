module Friendship

	class Friend

		attr_accessor :name, :sex, :age

		def initialize(name, sex, age)
			@name = name
			@sex = sex
			@age = age
		end

		def male?
			@sex == :male
		end

		def female?
			@sex == :female
		end

		def over_eighteen?
			@age > 18
		end

		def long_name?
			name.length > 10
		end

	end

	class Database
		include Enumerable
		def initialize(*friends)
			@friends = friends
		end

		def add_friend(name, sex, age)
			@friends.push Friend.new(name, sex, age)
		end

		def have_any_friends?
			!@friends.empty?
		end

		def each
			index = 0
			return to_enum unless block_given?
			while index < @friends.length
				yield(@friends[index])
				index += 1
			end
		end

		def find(hash)
			if hash[:name]
				@friends.select { |friend| friend.name == hash[:name] }
			elsif hash[:age]
				@friends.select { |friend| friend.age == hash[:age] }
			elsif hash[:sex]
				@friends.select { |friend| friend.sex == hash[:sex] }
			else
				@friends.select { |friend| hash[:filter].call(friend) }
			end
		end

		def unfriend(hash)
			@friends.delete_if { |x| find(hash).include?(x) }
		end
	end
end


# peter = Friendship::Friend.new('Peter', :male, 28)
# p peter.name
# p peter.sex
# p peter.age
# p peter.male?
# p peter.female?
# p peter.over_eighteen?
# p peter.long_name?

# friends = Friendship::Database.new
# friends.add_friend('Peter', :male, 28)
# friends.add_friend('Maria', :female, 25)

friends = Friendship::Database.new
# p friends
# p friends.have_any_friends?
friends.add_friend('Peter', :male, 28)
# p friends.have_any_friends?
friends.add_friend('Maria', :female, 25)
friends.add_friend('Denis', :male, 18)
# p friends

# friends_names = friends.map(&:name)
# puts friends_names

p friends.find(name: 'Maria')
p friends.find(age: 28)
p friends.find(sex: :male)
p friends.find(filter: ->(friend) { friend.male? && friend.age > 17 })

#p "Unfriend Peter: #{friends.unfriend(name: 'Peter')}"


# p friends.find(sex: :female)
puts friends.unfriend(filter: ->(friend) { friend.age == 25 })
p friends.map(&:name)