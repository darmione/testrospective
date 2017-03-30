require_relative "solution"

RSpec.describe Episode do

	let(:episode1) { Episode.new('Productivity', 'The first episode of Cortex, where we talk about being self-employed.', 100) }

	context 'Episode has attributes' do
		describe '#name' do
			it "tells us Episode's name" do
				expect(episode1.name).to eq("Productivity")
			end
		end

		describe '#description' do
			it "tells us Episode's description" do
				expect(episode1.description).to eq("The first episode of Cortex, where we talk about being self-employed.")
			end
		end

		describe '#duration' do
			it "tells us Episode's duration" do
				expect(episode1.minutes).to eq(100)
			end
		end

		describe '#id' do
			it "Episode's id is nil" do
				expect(episode1.id).to be nil
			end
		end
	end
end

class Podcast
	attr_reader :episodes
end

RSpec.describe Podcast do

	let(:cortex) { Podcast.new("Cortex") }
	let(:todolist) { Episode.new('TodoLists', 'Managing your day by todos', 68) }
	let(:productivity) { Episode.new('Productivity', 'The first episode of Cortex, where we talk about being self-employed.', 100) }
	let(:schedule) { Episode.new('Schedule', 'We will talk about how to schedule your day', 73) }

	context 'Podcast has attribute' do
		describe '#name' do
			it "tells us Podcast's name" do
				expect(cortex.name).to eq("Cortex")
			end
		end
	end

	describe "#<<" do
		it "adds Episodes to Podcast" do
			cortex << todolist

			expect(cortex.episodes.count).to eq 1
		end

		it "assignes correct id" do
			cortex << todolist
			cortex << productivity

			expect(todolist.id).to eq 1
			expect(productivity.id).to eq 2
		end
	end

	context "Find method works" do
		describe 'find by name' do
			it "matches episode by part of the name" do
				cortex << todolist
				cortex << productivity
				cortex << schedule
				expect(cortex.find(name: "od")).to match_array([productivity, todolist])
			end

			it "matches episode by the name in downcase" do
				cortex << todolist
				cortex << productivity
				cortex << schedule
				expect(cortex.find(name: "productivity")).to match_array([productivity])
			end

			it "doesn't match episode when name doesn't match" do
				cortex << todolist
				cortex << productivity
				cortex << schedule
				expect(cortex.find(name: "products")).to match_array([])
			end
		end

		describe 'find by description' do
			it "matches all episodes by all words from description" do
				cortex << todolist
				cortex << productivity
				cortex << schedule
				expect(cortex.find(description: ["your", "day"])).to match_array([todolist, schedule])
			end

			it "matches episode by all words from description" do
				cortex << todolist
				cortex << productivity
				cortex << schedule
				expect(cortex.find(description: ['We', 'will', 'talk'])).to match_array([schedule])
			end

			it "deosn't match episode when there's a word which is not part of the description" do
				cortex << todolist
				cortex << productivity
				cortex << schedule
				expect(cortex.find(description: ['We', 'will', 'test'])).to match_array([])
			end

			it "doesn't match episode when case of words from description is different" do
				cortex << todolist
				cortex << productivity
				cortex << schedule
				expect(cortex.find(description: ['How', 'to', 'schedule'])).to match_array([])
			end
		end
	end

	context "Info method works" do
		describe '#info' do
			it "prints podcast name" do
				episodes = [todolist, productivity, schedule]
				episodes.each { |episode| cortex << episode }
				expect(cortex.info).to include("Podcast: #{cortex.name}")
			end

			it "prints count of total episodes in podcast" do
				episodes = [todolist, productivity, schedule]
				episodes.each { |episode| cortex << episode }
				expect(cortex.info).to include("Total episodes: #{cortex.episodes.count}")
			end

			it "prints total duration of episodes in podcast" do
				episodes = [todolist, productivity, schedule]
				episodes.each { |episode| cortex << episode }
				sum = 0
				episodes.each do |episode|
					sum = sum + episode.minutes
				end
				expect(cortex.info).to include("Total duration: #{sum}")
			end

			it "prints episodes details and separation lines" do
				episodes = [todolist, productivity, schedule]
				episodes.each { |episode| cortex << episode }
				episodes.each do |episode|
					expect(cortex.info).to include("Episode #{episode.id}")
					expect(cortex.info).to include("Name: #{episode.name}")
					expect(cortex.info).to include("#{episode.description}")
					expect(cortex.info).to include("Duration: #{episode.minutes}")
					expect(cortex.info).to include("=" * 10)
				end
			end
		end
	end
end
