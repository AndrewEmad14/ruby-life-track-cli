# frozen_string_literal: true

require_relative 'lib/event'
require_relative 'lib/event_router'
require_relative 'lib/handlers/console_handler'
require_relative 'lib/handlers/file_handler'
require_relative 'lib/handlers/stats_handler'
require_relative 'lib/handlers/slack_handler'

# The main application orchestration class for LifeTrack CLI.
class LifeTrackApp
  OPTIONS = {
    1 => :work,
    2 => :study,
    3 => :exercise,
    4 => :meal
  }.freeze

  def initialize
    @router = EventRouter.new
    setup_handlers
  end

  # Sets up and registers the pluggable output handlers into the router.
  def setup_handlers
    @router.register(ConsoleHandler.new)
    @router.register(FileHandler.new)
    @router.register(StatsHandler.new)
    @router.register(SlackHandler.new) # Bonus Slack handler
  end

  # Starts the CLI application loop.
  def run
    loop do
      print_menu
      choice = prompt_choice
      
      if choice == 5
        puts "Exiting LifeTrack. Goodbye!"
        break
      elsif OPTIONS.key?(choice)
        log_event_for(OPTIONS[choice])
      else
        puts "Invalid choice. Please select 1-5."
      end
    end
  end

  private

  # Prints the standard CLI option menu.
  def print_menu
    puts "\n=== LifeTrack ==="
    puts "1. Log a work session"
    puts "2. Log a study session"
    puts "3. Log an exercise session"
    puts "4. Log a meal"
    puts "5. Exit"
  end

  # Prompts user to make a choice.
  # @return [Integer]
  def prompt_choice
    print "\nChoose an option: "
    gets.chomp.to_i
  end

  # Prompts for event details and dispatches it via the EventRouter.
  # @param event_type [Symbol]
  def log_event_for(event_type)
    print "Description: "
    description = gets.chomp
    
    print "Duration (minutes): "
    duration = gets.chomp.to_i

    event = Event.new(
      type: event_type,
      description: description,
      duration: duration
    )

    @router.dispatch(event)
    puts "✓ Event logged."
  end
end

# Executed only when run directly from the command line
if __FILE__ == $PROGRAM_NAME
  app = LifeTrackApp.new
  app.run
end
