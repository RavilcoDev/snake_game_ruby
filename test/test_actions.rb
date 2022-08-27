require "minitest/autorun"
require_relative "../src/actions/actions"
require_relative "../src/model/state"

class TestActions < Minitest::Test

  def setup
    @initial_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(1, 0)
      ]),
      Model::Food.new(4, 4),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false,
      0
    )
    @expected_state_secuence = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 2),
        Model::Coord.new(1, 1)
      ]),
      Model::Food.new(4, 4),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false,
      0
    )
  end

  def test_move_snake
    next_position = Model::Coord.new(1, 2)
    new_state = Actions::move_snake_to(@initial_state,next_position)
    assert_equal new_state, @expected_state_secuence
  end

  def test_position_valida?
    next_position = Model::Coord.new(1,2)

    is_valid_correct = Actions::position_is_valida?(@initial_state,next_position)
    assert_equal is_valid_correct, true

    out_grid = Model::Coord.new(-1,2)

    is_valid_grid = Actions::position_is_valida?(@initial_state,out_grid)
    assert_equal is_valid_grid, false
  end

  def test_change_direction_invalid
    tmp_state = @initial_state
    #down - up
    current_state = Actions::change_direction(tmp_state, Model::Direction::UP)
    assert_equal current_state, tmp_state
    # left - right

    tmp_state.curr_direction = Model::Direction::LEFT
    current_state = Actions::change_direction(tmp_state, Model::Direction::RIGHT)
    assert_equal current_state.curr_direction, Model::Direction::LEFT

    # right - left
    tmp_state.curr_direction = Model::Direction::RIGHT
    current_state = Actions::change_direction(tmp_state, Model::Direction::LEFT)
    assert_equal current_state.curr_direction, Model::Direction::RIGHT
  end

  def test_grow_snake
    initial_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(1, 0)
      ]),
      Model::Food.new(1, 2),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    next_position = Model::Coord.new(1, 2)

    current_state = Actions::move_snake(initial_state)

    assert_equal current_state.snake.positions, [
      Model::Coord.new(1, 2),
      Model::Coord.new(1, 1),
      Model::Coord.new(1, 0)
    ]
  end

  def test_generate_food
    initial_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(1, 0)
      ]),
      Model::Food.new(1, 2),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    next_food = Model::Food.new(0,0)


    Actions.stub(:rand, 0) do
      current_state = Actions::move_snake(initial_state)
      assert_equal current_state.food, next_food
    end
  end
end