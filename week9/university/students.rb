class University
  attr_accessor :name, :array_of_students

  def initialize(name, array_of_students = [])
    @name = name
    @array_of_students = array_of_students
  end

  def students
    @array_of_students
  end

  def <<(student)
    @array_of_students << student
  end

  def sort_by_grade_average
    @array_of_students.sort { |a, b| b.avg_grade <=> a.avg_grade }
  end

  def sort_by_difficulty_of_courses
    @array_of_students.sort do |a, b|
      b.count_hard_courses <=> a.count_hard_courses
    end
  end

  def graduated_students
    @array_of_students.select(&:graduated?)
  end

  def ungraduated_students
    @array_of_students.select { |student| !student.graduated? }
  end

  def sort_students_by_taken_courses
    @array_of_students.sort { |a, b| b.courses.size <=> a.courses.size }
  end

  def faculty_number_range(range)
    @array_of_students.select do |student|
      range.include?(student.faculty_number)
    end
  end
end

class Student
  attr_accessor :first_name, :last_name, :faculty_number, :courses

  def initialize(first_name, last_name, faculty_number)
    @first_name = first_name
    @last_name = last_name
    @faculty_number = faculty_number
    @courses = {}
  end

  def take_course(course, grade)
    @courses[course] = grade
  end

  def graduated?
    @courses.size >= 3 && avg_grade >= 5
  end

  def avg_grade
    @courses.values.inject { |sum, grade| sum + grade }.to_f / @courses.size
  end

  def courses
    @courses.keys
  end

  def count_easy_courses
    @courses.select { |course| course.difficulty == :easy }.size
  end

  def count_medium_courses
    @courses.select { |course| course.difficulty == :medium }.size
  end

  def count_hard_courses
    @courses.select { |course| course.difficulty == :hard }.size
  end

  def find_courses_by(difficulty:)
    @courses.keys
            .select { |course| course.difficulty == difficulty }
  end
end

class Course
  attr_accessor :course_name, :difficulty

  def initialize(course_name, difficulty)
    @course_name = course_name
    @difficulty = difficulty
  end
end

pesho = Student.new("Pesho", "Petrov", 8888)
stamat = Student.new("Stamat", "Stamatov", 9999)
johnny = Student.new("Johnny", "Johnson", 1111)

mathematics = Course.new("Mathematics", :hard)
programming = Course.new("Programming", :hard)
history = Course.new("History", :medium)
english = Course.new("English", :easy)

stamat.take_course(mathematics, 4.0)
stamat.take_course(programming, 5.0)
stamat.take_course(english, 5.0)

pesho.take_course(mathematics, 6.0)
pesho.take_course(history, 5.0)
pesho.take_course(english, 5.0)

johnny.take_course(history, 3.0)
johnny.take_course(english, 5.0)

oxford = University.new("Oxford", [pesho, stamat, johnny])
# p oxford
stanford = University.new("Stanford")
#p stanford
stanford << stamat
# p stanford
# p oxford.students
# p stamat.courses

# p oxford.students.map { |el| el.first_name }
# p oxford.sort_by_difficulty_of_courses
#
# p stamat.count_hard_courses
# p pesho.count_hard_courses
# p johnny.count_hard_courses
#
# p oxford.graduated_students
# p oxford.ungraduated_students
# p oxford.faculty_number_range(8000..10000)
# p oxford.sort_by_grade_average
# p stamat.count_hard_courses
# p stamat.graduated?
# p stamat.find_courses_by(difficulty: :easy)
# p oxford.graduated_students
