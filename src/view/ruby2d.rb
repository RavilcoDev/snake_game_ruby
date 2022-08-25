require 'ruby2d'

module View
  class Ruby2dView

    def initialize
      @pixel_size = 50
    end

    def render(state)
      extend Ruby2D::DSL
      set(
        title: "Snake",
        width: @pixel_size * state.grid.cols,
        height: @pixel_size * state.grid.rows
      )
      render_snake(state)
      render_food(state)
      show
    end

    private

    def render_food(state)
      extend Ruby2D::DSL
      food = state.food
      Square.new(
        x: @pixel_size * food.col,
        y: @pixel_size * food.row,
        size: @pixel_size,
        color: 'orange',
      )
    end

    def render_snake(state)
      extend Ruby2D::DSL
      snake = state.snake
      snake.positions.each do |pos|
        Square.new(
            x: @pixel_size * pos.col,
            y: @pixel_size * pos.row,
            size: @pixel_size,
            color: 'green',
        )
      end
    end
  end
end