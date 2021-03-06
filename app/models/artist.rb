class Artist

  attr_reader :name, :years_experience

  @@all = []

  def initialize(name, years_experience)
    @name = name
    @years_experience = years_experience
    @@all << self
  end

  def self.all
    @@all
  end

  def create_painting(title, price, gallery)
    Painting.new(title, price, self, gallery)
  end

  def paintings
    Painting.all.select {|painting| painting.artist == self}
  end

  def galleries
    paintings.map {|painting| painting.gallery}.uniq
  end

  def cities
    galleries.map {|gallery| gallery.city}
  end

  def self.total_experience
    self.all.map {|artist| artist.years_experience}.inject(0, :+)
  end

  def self.most_prolific
    painting_hash = Hash.new(0)
    Painting.all.map {|painting| painting_hash[painting.artist] += 1}
    painting_hash.sort_by {|k,v| k.years_experience / v}.first
  end

end
