# frozen_string_literal: true

require_relative 'base_handler'

# Simulates sending real-time event updates to a Slack channel via webhooks.
# This represents the bonus task requested by the product manager.
class SlackHandler < BaseHandler
  # @param webhook_url [String] Mock webhook URL for the Slack integration.
  def initialize(webhook_url = 'https://hooks.slack.com/services/mock/lifetrack')
    @webhook_url = webhook_url
  end

  # Simulates sending a payload containing the event data.
  # @param event [Event]
  def call(event)
    payload = {
      text: "⚡ *New LifeEvent Logged!* \n*Type:* #{event.type.to_s.upcase}\n*Desc:* #{event.description}\n*Duration:* #{event.duration} mins"
    }
    # For simulation purposes, we output to console that the mock Slack call was made.
    puts "[Slack Notification] Simulated POST to #{@webhook_url} with payload: #{payload[:text].gsub("\n", " | ")}"
  end
end
