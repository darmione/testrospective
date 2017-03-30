require_relative 'students'

RSpec.describe University do

  let(:oxford) { University.new("Oxford", [pesho, stamat, johnny]) }
  let(:pesho) { Student.new("Pesho", "Petrov", 8888) }
  let(:stamat) { Student.new("Stamat", "Stamatov", 9999) }
  let(:johnny) { Student.new("Johnny", "Johnson", 1111) }

  let(:mathematics) { Course.new("Mathematics", :hard) }
  let(:programming) { Course.new("Programming", :hard) }
  let(:history) { Course.new("History", :medium) }
  let(:english) { Course.new("English", :easy) }

  context 'University has attributes' do
    describe '#name' do
      it "tells us University's name" do
        expect(oxford.name).to eq('Oxford')
      end
    end

    describe '#array_of_students' do
      it 'gives us the array of students' do
        expect(oxford.array_of_students).to match_array([pesho, stamat, johnny])
      end
    end
  end

  describe '#<<' do
		it 'adds student to University' do
			oxford << pesho

			expect(oxford.students.count).to eq 4
		end
  end

  describe '#sort_by_grade_average' do
    it 'sorts students by the average of their grades' do
      stamat.take_course(mathematics, 4.0)
      stamat.take_course(programming, 5.0)
      stamat.take_course(english, 5.0)

      pesho.take_course(mathematics, 6.0)
      pesho.take_course(history, 5.0)
      pesho.take_course(english, 5.0)

      johnny.take_course(history, 3.0)
      johnny.take_course(english, 5.0)

      expect(oxford.sort_by_grade_average).to eq [pesho, stamat, johnny]
    end
  end

  describe '#sort_by_difficulty_of_courses' do
    it 'sorts students with biggest number of hard courses first' do
      stamat.take_course(mathematics, 4.0)
      stamat.take_course(programming, 5.0)
      stamat.take_course(english, 5.0)

      pesho.take_course(mathematics, 6.0)
      pesho.take_course(history, 5.0)
      pesho.take_course(english, 5.0)

      johnny.take_course(history, 3.0)
      johnny.take_course(english, 5.0)

      expect(oxford.sort_by_difficulty_of_courses).to eq [stamat, pesho, johnny]
    end

    it 'sorts students with biggest number of medium courses first when there is no students with hard courses' do
      stamat.take_course(history, 5.0)

      pesho.take_course(history, 5.0)
      pesho.take_course(history, 5.0)

      johnny.take_course(english, 5.0)

      expect(oxford.sort_by_difficulty_of_courses).to eq [pesho, stamat, johnny]
    end
  end

  describe '#graduated_students' do
    it 'returns array of students who have graduated' do
      stamat.take_course(mathematics, 4.0)
      stamat.take_course(programming, 5.0)
      stamat.take_course(english, 5.0)

      pesho.take_course(mathematics, 6.0)
      pesho.take_course(history, 5.0)
      pesho.take_course(english, 5.0)

      johnny.take_course(history, 3.0)
      johnny.take_course(english, 5.0)

      expect(oxford.graduated_students).to match_array [pesho]
    end

    it 'returns empty array if no students have graduated' do
      stamat.take_course(history, 5.0)

      pesho.take_course(history, 5.0)
      pesho.take_course(programming, 5.0)
      pesho.take_course(english, 4.0)

      johnny.take_course(english, 5.0)
      pesho.take_course(programming, 5.0)

      expect(oxford.graduated_students).to match_array []
    end
  end

  describe '#ungraduated_students' do
    it 'returns array of students who have not graduated' do
      stamat.take_course(mathematics, 4.0)
      stamat.take_course(programming, 5.0)
      stamat.take_course(english, 5.0)

      pesho.take_course(mathematics, 6.0)
      pesho.take_course(history, 5.0)
      pesho.take_course(english, 5.0)

      johnny.take_course(history, 3.0)
      johnny.take_course(english, 5.0)

      expect(oxford.ungraduated_students).to match_array [stamat, johnny]
    end

    it 'returns empty array if all students have graduated' do
      stamat.take_course(history, 5.0)
      stamat.take_course(english, 5.0)
      stamat.take_course(programming, 5.0)

      pesho.take_course(history, 5.0)
      pesho.take_course(programming, 6.0)
      pesho.take_course(english, 4.0)

      johnny.take_course(english, 6.0)
      johnny.take_course(programming, 5.0)
      johnny.take_course(history, 5.0)

      expect(oxford.ungraduated_students).to match_array []
    end
  end

  describe '#sort_students_by_taken_courses' do
    it 'sort students by number of taken courses' do
      stamat.take_course(mathematics, 4.0)

      pesho.take_course(mathematics, 6.0)
      pesho.take_course(history, 5.0)
      pesho.take_course(english, 5.0)

      johnny.take_course(history, 3.0)
      johnny.take_course(english, 5.0)

      expect(oxford.sort_students_by_taken_courses).to eq [pesho, johnny, stamat]
    end
  end

  describe '#faculty_number_range' do
    it 'filter students whose faculty number is in a range' do
      expect(oxford.faculty_number_range(8000..10000)).to eq [pesho, stamat]
    end

    it 'returns empty array of students if their faculty number is not in a range' do
      expect(oxford.faculty_number_range(1..10)).to eq []
    end
  end

end

RSpec.describe Student do

  let(:pesho) { Student.new("Pesho", "Petrov", 8888) }
  let(:programming) { Course.new("Programming", :hard) }
  let(:mathematics) { Course.new("Mathematics", :hard) }
  let(:history) { Course.new("History", :medium) }
  let(:english) { Course.new("English", :easy) }

  context 'Student has attributes' do
    describe '#first_name' do
      it "tells us Students's first name" do
        expect(pesho.first_name).to eq('Pesho')
      end
    end

    describe '#last_name' do
      it "tells us Students's last name" do
        expect(pesho.last_name).to eq('Petrov')
      end
    end

    describe '#faculty_number' do
      it "tells us Students's faculty number" do
        expect(pesho.faculty_number).to eq(8888)
      end
    end

    describe '#courses' do
      it 'courses hash is empty' do
        expect(pesho.courses).to be_empty
      end
    end
  end

  describe '#take_course' do
    it 'Student can take courses' do
      pesho.take_course(programming, 5.0)
      pesho.take_course(history, 6.0)

      expect(pesho.courses.count).to eq 2
    end
  end

  context 'graduated method works correctly' do
    describe '#graduated?' do
      it 'is false when student took less than 3 courses' do
        pesho.take_course(programming, 5.0)
        pesho.take_course(history, 6.0)

        expect(pesho.graduated?).to be false
      end

      it 'is false when student took 3 courses with avg grade is lower than 5.0' do
        pesho.take_course(programming, 5.0)
        pesho.take_course(history, 6.0)
        pesho.take_course(english, 3.0)

        expect(pesho.graduated?).to be false
      end

      it 'is true when student took 3 courses with avg grade is equal or greater than 5.0' do
        pesho.take_course(programming, 5.0)
        pesho.take_course(history, 6.0)
        pesho.take_course(english, 5.0)

        expect(pesho.graduated?).to be true
      end
    end
  end

  context 'avg_grade method works correctly' do
    describe '#avg_grade?' do
      it 'is correct for 2 courses' do
        pesho.take_course(programming, 5.0)
        pesho.take_course(history, 6.0)

        expect(pesho.avg_grade).to eq 5.5
      end

      it 'is correct for 3 courses' do
        pesho.take_course(programming, 5.0)
        pesho.take_course(history, 6.0)
        pesho.take_course(english, 4.0)

        expect(pesho.avg_grade).to eq 5.0
      end

      it 'is correct for 4 courses' do
        pesho.take_course(mathematics, 3.0)
        pesho.take_course(programming, 5.0)
        pesho.take_course(history, 6.0)
        pesho.take_course(english, 5.0)

        expect(pesho.avg_grade).to eq 4.75
      end
    end
  end

  context 'courses method works correctly' do
    describe '#courses' do
      it 'returns empty array if student has taken no courses' do
        expect(pesho.courses).to match_array []
      end

      it 'returns array of courses the student has taken' do
        pesho.take_course(programming, 5.0)
        pesho.take_course(history, 6.0)

        expect(pesho.courses).to match_array [programming, history]
      end
    end
  end

  context "courses' difficulty count methods work correctly" do
    describe '#count_*_courses' do
      it 'returns correct count of easy courses taken by student' do
        pesho.take_course(english, 5.0)
        expect(pesho.count_easy_courses).to eq 1
      end

      it 'returns correct count of medium courses taken by student' do
        pesho.take_course(history, 5.0)
        expect(pesho.count_medium_courses).to eq 1
      end

      it 'returns correct count of hard courses taken by student' do
        pesho.take_course(programming, 5.0)
        pesho.take_course(mathematics, 5.0)
        expect(pesho.count_hard_courses).to eq 2
      end
    end
  end

  describe '#find_courses_by' do
    it 'returns empty array when no courses match difficulty' do
      pesho.take_course(english, 5.0)
      pesho.take_course(programming, 5.0)
      pesho.take_course(mathematics, 5.0)
      expect(pesho.find_courses_by(difficulty: :medium)).to match_array []
    end

    it 'returns correct array of courses matched by easy difficulty' do
      pesho.take_course(english, 5.0)
      pesho.take_course(programming, 5.0)
      pesho.take_course(mathematics, 5.0)
      expect(pesho.find_courses_by(difficulty: :easy)).to match_array [english]
    end

    it 'returns correct array of courses matched by hard difficulty' do
      pesho.take_course(english, 5.0)
      pesho.take_course(programming, 5.0)
      pesho.take_course(mathematics, 5.0)
      expect(pesho.find_courses_by(difficulty: :hard)).to match_array [programming, mathematics]
    end
  end
end

RSpec.describe Class do

  let(:mathematics) { Course.new("Mathematics", :hard) }

  context 'Course has attributes' do
    describe '#course_name' do
      it "tells us Course's name" do
        expect(mathematics.course_name).to eq('Mathematics')
      end
    end

    describe '#difficulty' do
      it "tells us Course's difficulty" do
        expect(mathematics.difficulty).to eq(:hard)
      end
    end
  end
end
