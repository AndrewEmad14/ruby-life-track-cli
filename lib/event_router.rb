# frozen_string_literal: true

# The EventRouter acts as the Subject in the Observer pattern.
# It maintains a collection of registered handlers (Observers) and dispatches
# events to all of them. It has zero knowledge of concrete handler classes,
# depending solely on the Handler interface (#call method), adhering to Dependency Inversion.
class EventRouter
  def initialize
    @handlers = []
  end

  # Registers a new handler in the event pipeline.
  # @param handler [#call] An object that implements the BaseHandler contract/interface.
  def register(handler)
    # Validate contract interface at registration time as a safeguard
    unless handler.respond_to?(:call)
      raise ArgumentError, "Handler #{handler.class} must implement the #call method."
    end

    @handlers << handler
  end

  # Dispatches the given event simultaneously to all registered handlers.
  # @param event [Event] The logged event to dispatch.
  def dispatch(event)
    @handlers.each do |handler|
      handler.call(event)
    end
  end
end
