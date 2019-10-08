# frozen_string_literal: false

class Player
  attr_accessor :mark
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
