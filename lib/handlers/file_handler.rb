# frozen_string_literal: true

require_relative 'base_handler'

# Writes event logs to a text file.
# Adheres to Single Responsibility: its only job is writing to the log file.
class FileHandler < BaseHandler
  # @param filepath [String] Path to the log file.
  def initialize(filepath = 'lifetrack.log')
    @filepath = filepath
  end

  # Appends the formatted event details to the log file.
  # @param event [Event]
  def call(event)
    timestamp_str = event.timestamp.strftime('%Y-%m-%d %H:%M')
    log_line = "[#{timestamp_str}] #{event.type.to_s.upcase} — #{event.description} (#{event.duration} min)\n"
    
    File.open(@filepath, 'a') do |file|
      file.write(log_line)
    end
  end
end
