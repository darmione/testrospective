require_relative 'TodoList'
require 'date'

RSpec.describe Todo do

  let (:todo1) { Todo.new('Take dog out', 'I should take out the dog', 'High', '24.02.2017') }

  context 'Todo has attributes' do
    describe '#name' do
      it "tells us Todo's name" do
        expect(todo1.name).to eq("Take dog out")
      end
    end

    describe '#description' do
      it "tells us Todo's description" do
        expect(todo1.description).to eq("I should take out the dog")
      end
    end

    describe '#priority' do
      it "tells us Todo's priority" do
        expect(todo1.priority).to eq('high')
      end
    end

    describe '#date' do
      it "Episode's id is nil" do
        expect(todo1.date).to eq(DateTime.parse '24.02.2017')
      end
    end
  end
end

RSpec.describe Organizer do

  let (:organizer) { Organizer.new }
  let (:todo1) { Todo.new('Take dog out', 'I should take out the dog', 'High', '24.02.2017') }
  let (:todo2) { Todo.new('Dishes', 'Wash the dishes', 'Low', '24.02.2018') }
  let (:todo3) { Todo.new('Study', 'Study for exam', 'Critical', '27.02.2017') }

  describe '#<<' do
    it "adds todo to organizer" do
      organizer << todo1

      expect(organizer.todos.count).to eq 1
    end
  end

  context 'List method works' do
    describe '#list' do
      it 'prints id, name, description, priority row' do
        organizer << todo1

        expect(organizer.list).to include("Id |", "Name |", "Description |", "Priority |")
      end

      it 'prints all todos details' do
        todos = [todo1, todo2, todo3]
        todos.each { |todo| organizer << todo }
        index = 0
        todos.each do |todo|
          expect(organizer.list).to include("#{index + 1}")
          expect(organizer.list).to include("#{todo.name}")
          expect(organizer.list).to include("#{todo.description}")
					expect(organizer.list).to include("#{todo.priority}")
          expect(organizer.list).to include("#{todo.date.strftime('%d.%m.%Y')}")
        end
      end
    end
  end

  describe '#take' do
    it 'prints correct todos' do
      todos = [todo1, todo2, todo3]
      todos.each { |todo| organizer << todo }

      expect(organizer.take(2).list).not_to include("#{3}")
    end
  end

  context 'Order method works with by priority, by date and in asc, desc order' do
    describe '#order by priority' do
      it 'returns todos in asc order' do
        todos = [todo1, todo2, todo3]
        todos.each { |todo| organizer << todo }
        organizer.order(by: :priority, order: :asc)

        expect(organizer.todos.map{ |todo| todo.priority })
          .to eq(['low', 'high', 'critical'])
      end

      it 'returns todos in desc order' do
        todos = [todo1, todo2, todo3]
        todos.each { |todo| organizer << todo }
        organizer.order(by: :priority, order: :desc)

        expect(organizer.todos.map{ |todo| todo.priority })
          .to eq(['critical', 'high', 'low'])
      end
    end

    describe '#order by date' do
      it 'returns todos in asc order' do
        todos = [todo1, todo2, todo3]
        todos.each { |todo| organizer << todo }
        organizer.order(by: :date, order: :asc)

        expect(organizer.todos.map{ |todo| todo.date.strftime('%d.%m.%Y') })
          .to eq(['24.02.2017', '27.02.2017', '24.02.2018'])
      end

      it 'returns todos in desc order' do
        todos = [todo1, todo2, todo3]
        todos.each { |todo| organizer << todo }
        organizer.order(by: :date, order: :desc)

        expect(organizer.todos.map{ |todo| todo.date.strftime('%d.%m.%Y') })
          .to eq(['24.02.2018', '27.02.2017', '24.02.2017'])
      end
    end
  end

  describe '#start' do
    it 'returns todos as enum' do
      todos = [todo1, todo2, todo3]
      todos.each { |todo| organizer << todo }
      doing_tasks = organizer.start

      expect(doing_tasks.next).to eq (todo1)
    end
  end
end
