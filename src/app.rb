require_relative "view/ruby2d"
require_relative "model/state"
require_relative "actions/actions"

class App
  def initialize
    @state = Model::initial_state
    @loop_time = 0.2
    @last_points = 0
  end

  def start
    view = View::Ruby2dView.new(self)
    timer_thread = Thread.new { init_timer(view) }
    view.start(@state)
    timer_thread.join
  end

  def init_timer(view)
    while !@state.game_finished do
      view.renderGame(@state)
      sleep @loop_time
      @state = Actions::move_snake(@state)
      if @last_points != @state.snake.positions.length - 2 && @loop_time > 0.01
        @loop_time -= 0.01
        @last_points == @state.snake.positions.length - 2
      end
    end
    view.renderEndGame(@state)
  end

  def send_action(action, params)
    new_state = Actions.send(action, @state, params)
    if new_state.hash != @state.hash
      @state = new_state
      view.renderGame(@state)
    end
  end
end

app = App.new
app.start