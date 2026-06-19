# frozen_string_literal: true

# Represents a life event logged by the user in the LifeTrack application.
# This class acts as a simple data-carrying object (DTO) without any business
# logic or knowledge of how it is processed, adhering to the Single Responsibility Principle.
class Event
  attr_reader :type, :description, :duration, :timestamp

  # Initializes a new Life Event.
  # @param type [Symbol] The category of the event (e.g. :WORK, :STUDY, :EXERCISE, :MEAL)
  # @param description [String] A brief description of what was done
  # @param duration [Integer] The duration of the event in minutes
  # @param timestamp [Time] When the event occurred (defaults to the current time)
  def initialize(type:, description:, duration:, timestamp: Time.now)
    @type = type
    @description = description
    @duration = duration
    @timestamp = timestamp
  end
end
