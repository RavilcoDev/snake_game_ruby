module Model
  module Direction
    UP = :up
    RIGTH = :rigth
    DOWN = :down
    LEFT = :left
  end

  class Coord < Struct.new(:col, :row)
  end

  class Food < Coord
  end

  class Snake < Struct.new(:positions)
  end

  class Grid < Struct.new(:cols, :rows)
  end

  class State < Struct.new(:snake, :food, :grid, :curr_direction, :game_finished)
  end

  def self.initial_state
    Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(1, 0)
      ]),
      Model::Food.new(4, 4),
      Model::Grid.new(12, 8),
      Direction::DOWN,
      false
    )
  end
end