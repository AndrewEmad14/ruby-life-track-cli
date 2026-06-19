# frozen_string_literal: true

# Base interface/contract class for all event outputs/handlers.
# Enforces that subclass handlers implement the required `#call` method at runtime.
class BaseHandler
  # Dispatches/handles a single event.
  # @param event [Event] The life event to process.
  # @raise [NotImplementedError] If the subclass does not implement this method.
  def call(event)
    raise NotImplementedError, "#{self.class} must implement the #call(event) method."
  end
end
