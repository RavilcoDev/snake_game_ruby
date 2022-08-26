require_relative "../model/state"
module Actions
  def self.move_snake(state)
    next_direction = state.next_direction
    next_position = calc_next_position(state, next_direction)
    if(position_valida?(state,next_position))
      move_snake_to(state, next_position)
    else
      end_game state
    end
  end

  def self.calc_next_position(state,next_direction)
    current_position = state.snake.positions.first
    case next_direction
      when Model::Direction::UP
        return Model::Coord.new(current_position.col,
          current_position.row - 1)
      when Model::Direction::RIGTH
        return Model::Coord.new(current_position.col + 1,
          current_position.row)
      when Model::Direction::DOWN
        return Model::Coord.new(current_position.col,
          current_position.row + 1)
      when Model::Direction::LEFT
        return Model::Coord.new(current_position.col + 1,
          current_position.row)
    end
  end

  def self.position_valida?(state,next_position)
    is_valid = next_position.col < 0 ||
      next_position.row < 0 ||
      next_position.col > state.grid.cols ||
      next_position.row > state.grid.rows
    return !is_valid || state.snake.positions.include?(next_position)
  end

  def self.move_snake_to(state, next_position)
    state.snake.positions = [next_position] + state.snake.positions[0...-1]
    state
  end

  def self.end_game(state)
    state.game_finished = true
    state
  end
end