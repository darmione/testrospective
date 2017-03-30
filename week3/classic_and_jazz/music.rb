class Song
  attr_accessor :name, :artist, :genre, :subgenre, :tags

  def initialize(name, artist, genre, subgenre, tags)
    @name = name
    @artist = artist
    @genre = genre
    @subgenre = subgenre
    @tags = tags
  end

  def matches_name?(lookup_str)
    @name == lookup_str
  end

  def matches_artist?(lookup_str)
    @artist == lookup_str
  end

  def matches_genre?(lookup_str)
    @genre == lookup_str
  end

  def matches_subgenre?(lookup_str)
    @subgenre == lookup_str
  end

  def matches_filter?(lambda)
    lambda.call(self)
  end

  def matches_tags?(criteria)
    if criteria.instance_of? Array
      criteria.all? do |tag|
        tag.end_with?('!') ? !@tags.include?(tag.chop) : @tags.include?(tag)
      end
    else
      @tags.include? criteria
    end
  end
end

class Collection
  attr_accessor :songs_as_string, :artist_tags, :parsed_songs

  def initialize(songs_as_string, artist_tags = {})
    @songs_as_string = songs_as_string
    @artist_tags = artist_tags
    @parsed_songs = parsed_songs
  end

  def parse
    @parsed_songs = songs_as_string.lines.map do |line|
      name, artist, genre, tags = line.split('.').map(&:strip)
      genre, subgenre = genre.split(', ')
      tags ? tags = tags.split(', ') : tags = []
      tags << genre.downcase
      tags << subgenre.downcase unless subgenre.nil?
      tags.push(*artist_tags[artist]) if artist_tags[artist]
      Song.new(name, artist, genre, subgenre, tags)
    end
  end

  def find(criteria = {})
    @parsed_songs.select do |song|
      criteria.all? do |key, value|
        song.send("matches_#{key}?", value)
      end
    end
  end
end

songs_as_string = "My Favourite Things.          John Coltrane.      Jazz, Bebop.        popular, cover
Greensleves.                  John Coltrane.      Jazz, Bebop.        popular, cover
Alabama.                      John Coltrane.      Jazz, Avantgarde.   melancholic
Acknowledgement.              John Coltrane.      Jazz, Avantgarde
Afro Blue.                    John Coltrane.      Jazz.               melancholic
'Round Midnight.              John Coltrane.      Jazz
My Funny Valentine.           Miles Davis.        Jazz.               popular
Tutu.                         Miles Davis.        Jazz, Fusion.       weird, cool
Miles Runs the Voodoo Down.   Miles Davis.        Jazz, Fusion.       weird
Boplicity.                    Miles Davis.        Jazz, Bebop
Autumn Leaves.                Bill Evans.         Jazz.               popular
Waltz for Debbie.             Bill Evans.         Jazz
'Round Midnight.              Thelonious Monk.    Jazz, Bebop
Ruby, My Dear.                Thelonious Monk.    Jazz.               saxophone
Fur Elise.                    Beethoven.          Classical.          popular
Moonlight Sonata.             Beethoven.          Classical.          popular
Pathetique.                   Beethoven.          Classical
Toccata e Fuga.               Bach.               Classical, Baroque. popular
Goldberg Variations.          Bach.               Classical, Baroque
Eine Kleine Nachtmusik.       Mozart.             Classical.          popular, violin
"
artist_tags = {
  'John Coltrane' => %w[saxophone],
  'Beethoven' => %w[piano polyphony],
}

collection = Collection.new(songs_as_string, artist_tags)
collection.parse
# p collection.find genre: 'Jazz', artist: 'John Coltrane'
# p collection.find artist: 'Mozart'
p collection.find name: 'Greensleves'
# p collection.find genre: 'Classical'
# p collection.find subgenre: 'Baroque'
# p collection.find tags: 'fusion'
# p collection.find tags: %w[jazz bebop! saxophone! popular!]
# p collection.find tags: %w[jazz piano!]
# p collection.find tags: 'popular', artist: 'John Coltrane'
p collection.find filter: ->(song) { song.name.start_with?('My') }
