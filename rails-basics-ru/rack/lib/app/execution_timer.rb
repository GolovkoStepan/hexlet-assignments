# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    time = Time.now
    status, headers, body = @app.call(env)
    puts "Requet execution: #{Time.now - time} seconds."

    [status, headers, body]
    # END
  end
end
