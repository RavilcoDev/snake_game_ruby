require_relative "../model/state"
module Actions
  def self.move_snake(state)
    curr_direction = state.curr_direction
    next_position = calc_next_position( state, curr_direction )
    if next_position_is_food?( state, next_position )
      grow_snake_to( state, next_position )
      generate_food( state )
    elsif position_is_valida?( state, next_position )
      move_snake_to( state, next_position )
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
      when Model::Direction::RIGHT
        return Model::Coord.new(current_position.col + 1,
          current_position.row)
      when Model::Direction::DOWN
        return Model::Coord.new(current_position.col,
          current_position.row + 1)
      when Model::Direction::LEFT
        return Model::Coord.new(current_position.col - 1,
          current_position.row)
    end
  end

  def self.position_is_valida?(state,next_position)
    is_out_grid = next_position.col < 0 ||
      next_position.row < 0 ||
      next_position.col > state.grid.cols - 1 ||
      next_position.row > state.grid.rows - 1
    is_snake_tail = state.snake.positions.include?(next_position)
    return !is_out_grid && !is_snake_tail
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
    right = Model::Direction::RIGHT
    left = Model::Direction::LEFT

    return !(current_direction == direction ||
      current_direction == up && direction == down ||
      current_direction == down && direction == up ||
      current_direction == right && direction == left ||
      current_direction == left && direction == right)
  end

  def self.move_snake_to(state, next_position)
    state.snake.positions = [next_position] + state.snake.positions[0...-1]
    state
  end

  def self.next_position_is_food?(state, next_position)
    return next_position.col == state.food.col &&
      next_position.row == state.food.row
  end

  def self.grow_snake_to(state, next_position)
    state.snake.positions = [next_position] +  state.snake.positions
    state
  end

  def self.generate_food(state)
    state.food = Model::Food.new( rand( state.grid.cols ), rand( state.grid.rows ) )
    state
  end
  def self.end_game(state)
    state.game_finished = true
    state
  end
end