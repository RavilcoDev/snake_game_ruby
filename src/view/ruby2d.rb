require 'ruby2d'
require_relative "../model/state"

module View
  class Ruby2dView

    def initialize( app )
      @pixel_size = 20
      @app = app
    end

    def start(state)
      extend Ruby2D::DSL
      set(
        title: "Snake",
        width: @pixel_size * state.grid.cols,
        height: @pixel_size * state.grid.rows
      )

      on :key_down do |event|
        handle_key_event(event)
      end

      show
    end

    def renderGame(state)
      extend Ruby2D::DSL
      clear
      render_snake(state)
      render_food(state)
    end

    def renderEndGame(state)
      extend Ruby2D::DSL
      head = state.snake.positions.first
      Square.new(
          x: @pixel_size * head.col,
          y: @pixel_size * head.row,
          size: @pixel_size,
          color: 'red',
      )
      Text.new(
        "End Game",
        x: 100, y: 100,
        size: 60
      )
      Text.new(
        "#{state.snake.positions.length-2} points",
        x: 100, y: 180,
        size: 50
      )
      sleep(3)
      close
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

    def handle_key_event(event)
      case event.key
      when "up"
        @app.send_action(:change_direction, Model::Direction::UP)
      when "down"
        @app.send_action(:change_direction, Model::Direction::DOWN)
      when "right"
        @app.send_action(:change_direction, Model::Direction::RIGHT)
      when "left"
        @app.send_action(:change_direction, Model::Direction::LEFT)
    end
    end
  end
end