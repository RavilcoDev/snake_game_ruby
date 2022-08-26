require "minitest/autorun"
require_relative "../src/actions/actions"
require_relative "../src/model/state"

class TestActions < Minitest::Test
  def test_move_snake
    initial_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(1, 0)
      ]),
      Model::Food.new(4, 4),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    expected_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 2),
        Model::Coord.new(1, 1)
      ]),
      Model::Food.new(4, 4),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    next_position = Model::Coord.new(1, 2)
    new_state = Actions::move_snake_to(initial_state,next_position)
    assert_equal new_state, expected_state
  end

  def test_position_valida?
    initial_state = Model::State.new(
      Model::Snake.new([
        Model::Coord.new(1, 1),
        Model::Coord.new(1, 0)
      ]),
      Model::Food.new(4, 4),
      Model::Grid.new(8, 12),
      Model::Direction::DOWN,
      false
    )

    next_position = Model::Coord.new(1,2)

    is_valid_correct = Actions::position_valida?(initial_state,next_position)
    assert_equal is_valid_correct, true

    out_grid = Model::Coord.new(-1,2)

    is_valid_grid = Actions::position_valida?(initial_state,out_grid)
    assert_equal is_valid_grid, false
  end
end