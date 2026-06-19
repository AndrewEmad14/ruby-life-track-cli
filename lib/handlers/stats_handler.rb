# frozen_string_literal: true

require_relative 'base_handler'

# Collects all events during the application session and automatically prints
# a statistical summary when the application exits.
# Adheres to Single Responsibility and achieves automatic execution via Ruby's at_exit hook.
class StatsHandler < BaseHandler
  def initialize
    @events = []
    # Register an at_exit hook to automatically print the stats on program termination.
    # This prevents the main menu loop from having to call or know about this handler's output step.
    at_exit { print_summary }
  end

  # Collects an event in memory.
  # @param event [Event]
  def call(event)
    @events << event
  end

  private

  # Outputs a formatted statistical summary of all logged events to stdout.
  def print_summary
    # If no events were logged, do not clutter the output
    return if @events.empty?

    puts "\n"
    puts "========================================"
    puts "        LIFETRACK SESSION SUMMARY       "
    puts "========================================"
    puts "Total Events:        #{@events.size}"
    
    total_duration = @events.sum(&:duration)
    puts "Total Duration:      #{total_duration} minutes"
    puts "----------------------------------------"
    puts "Breakdown by Category:"
    
    # Group and count events by their type
    grouped = @events.group_by(&:type)
    grouped.each do |type, list|
      count = list.size
      duration = list.sum(&:duration)
      puts "  • #{type.to_s.upcase.ljust(8)} : #{count} session(s) (#{duration} min)"
    end
    puts "========================================"
    puts "\n"
  end
end
