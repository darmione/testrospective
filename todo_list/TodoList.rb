require 'date'

class Todo

	attr_accessor :name, :description, :priority, :date

	def initialize(name, description, priority, date)
		@name = name
		@description = description
		@priority = priority.downcase
		@date = DateTime.parse(date)
	end
end

class Organizer

	attr_accessor :todos

	@@priorities = {"low" => 0, "medium" => 1, "high" => 2, "critical" => 3}
	def initialize(*todos)
		@todos = todos
	end

	def list
		name_length = @todos.map { |el| el.name.length }.max
		desc_length = @todos.map { |el| el.description.length }.max
		prio_length = @todos.map { |el| el.priority.length }.max
		date_length = @todos.map { |el| el.date.strftime('%d.%m.%Y').to_s.length }.max
		str = "#{"Id".rjust(2)} | #{"Name".rjust(name_length)} | #{"Description".rjust(desc_length)} | #{"Priority".rjust(prio_length)} | #{"Date".rjust(date_length)} |\n"
		@todos.each_with_index do |todo, index|
			str += "#{(index + 1).to_s.rjust(2)} | #{todo.name.rjust(name_length)} | #{todo.description.rjust(desc_length)} | #{todo.priority.rjust(prio_length)} | #{todo.date.strftime('%d.%m.%Y').rjust(date_length)} |\n"
		end
		str
	end

	def <<(todo)
		@todos << todo
	end

	def take(n)
		new_organizer = Organizer.new
		@todos.slice(0, n).each { |el| new_organizer << el }
		new_organizer
	end

	def order(hash)
		order_by = hash[:by]
		sort = hash[:order]
		if order_by == :priority
			if sort == :asc
				@todos = @todos.sort { |a, b| @@priorities[a.priority] <=> @@priorities[b.priority]}
			elsif sort == :desc
				@todos = @todos.sort { |a, b| @@priorities[b.priority] <=> @@priorities[a.priority]}
			end
		elsif order_by == :date
			if sort == :asc
				@todos = @todos.sort { |a, b| [a.date] <=> [b.date]}
			elsif sort == :desc
				@todos = @todos.sort { |a, b| [b.date] <=> [a.date]}
			end
		end
	end

	def start
		@todos.to_enum
	end
end

todo1 = Todo.new('Take dog out', 'I should take out the dog', 'High', '24.02.2017')
todo2 = Todo.new('Dishes', 'Wash the dishes', 'Low', '24.02.2018')

organizer = Organizer.new todo1, todo2

#p organizer

todo3 = Todo.new('Study', 'Study for exam', 'Critical', '27.02.2017')

organizer << todo3

#p organizer

# p todo1.name
# p todo1.description
# p todo1.priority
# p todo1.date

# print organizer.list
# print organizer.take(2).list
# organizer.order(by: :priority, order: :asc)
# print organizer.list
# organizer.order(by: :priority, order: :desc)
# print organizer.list
# organizer.order(by: :date, order: :asc)
# print organizer.list
# organizer.order(by: :date, order: :desc)
# print organizer.list
doing_tasks = organizer.start
p doing_tasks.next
p doing_tasks.next.name
