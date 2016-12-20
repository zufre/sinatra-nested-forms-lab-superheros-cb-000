class SuperHero
  attr_accessor :name, :power, :bio

  def self.all
    @@all ||= []
  end

  def initialize(opts={})
    @name  = opts[:name]
    @power = opts[:power]
    @bio   = opts[:bio]
    self.save
  end

  def save
    self.class.all << self
  end
end
