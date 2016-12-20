class Team
  attr_accessor :name, :motto

  def initialize(opts={})
    @name  = opts[:name]
    @motto = opts[:motto]
  end
end
