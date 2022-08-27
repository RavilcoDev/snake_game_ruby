require_relative "../model/state"
module Actions
  def self.move_snake(state)
    curr_direction = state.curr_direction
    next_position = calc_next_position(state, curr_direction)
    if(position_is_valida?(state,next_position))
      move_snake_to(state, next_position)
    else
      end_game state
    end
  end

  def self.calc_next_position(state,curr_direction)
    current_position = state.snake.positions.first
    case curr_direction
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

  def self.position_is_valida?(state,next_position)
    is_valid = next_position.col < 0 ||
      next_position.row < 0 ||
      next_position.col > state.grid.cols ||
      next_position.row > state.grid.rows
    return !is_valid || state.snake.positions.include?(next_position)
  end

  def self.change_direction(state, direction)
    if next_direction_is_valid?(state, direction)
      state.curr_direction = direction
    end
    state
  end

  def self.next_direction_is_valid?(state,direction)
    current_direction = state.curr_direction
    up = Model::Direction::UP
    down = Model::Direction::DOWN
    rigth = Model::Direction::RIGTH
    left = Model::Direction::LEFT

    return !(current_direction == direction ||
      current_direction == up && direction == down ||
      current_direction == down && direction == up ||
      current_direction == rigth && direction == rigth ||
      current_direction == left && direction == left)
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