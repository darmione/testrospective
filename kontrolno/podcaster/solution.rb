class Episode

	attr_accessor :id, :name, :description, :minutes

	def initialize(name, description, minutes)
		@name = name
		@description = description
		@minutes = minutes
	end
end

class Podcast
	attr_accessor :name

	def initialize(name)
		@name = name
		@episodes = []
		@count = 1
	end

	def <<(episode)
		episode.id = @count
		@count += 1
		@episodes << episode
	end

	def info
		sum = 0
		@episodes.each { |el| sum += el.minutes }
		str = "Podcast: #{name}\nTotal episodes: #{@episodes.size}\nTotal duration: #{sum}\n==========\n"
		str+=@episodes.map do |episode|
			"Episode #{episode.id}\nName: #{episode.name}\n#{episode.description}\nDuration: #{episode.minutes} minutes\n"
		end.join("==========\n")
		str
	end

	def find(hash)
		if hash[:name]
			@episodes.select { |x| x.name.downcase.include? hash[:name] }
		else hash[:description]
			p hash[:description]
			@episodes.select { |x| x.description.include? hash[:description][0] }
		end
	end
end

episode1 = Episode.new('Productivity', 'The first episode of Cortex, where we talk about being self-employed.', 100)
episode2 = Episode.new('TodoLists', 'Managing your day by todos', 68)
cortex = Podcast.new("Cortex")
cortex << episode1
cortex << episode2
# p cortex
episode3 = Episode.new('Schedule', 'We Will Talk about How to schedule your day', 73)
cortex << episode3
# p cortex
#print cortex.info

# p cortex.find(name: 'productivity') #=> [episode1]
# p cortex.find(name: 'od') #=> [episode1, episode2]
p cortex.find(description: ['your', 'day']) #=> [episode2, episode3]
p cortex.find(description: ['we', 'will', 'talk']) #=> [episode3]
