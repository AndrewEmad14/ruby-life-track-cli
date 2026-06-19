# frozen_string_literal: true

require_relative 'base_handler'

# Prints event logs to the terminal/standard output.
# Adheres to Single Responsibility: its only job is stdout formatting and display.
class ConsoleHandler < BaseHandler
  # Prints the formatted event details.
  # @param event [Event]
  def call(event)
    timestamp_str = event.timestamp.strftime('%Y-%m-%d %H:%M')
    puts "\n[#{timestamp_str}] #{event.type.to_s.upcase} — #{event.description} (#{event.duration} min)"
  end
end
