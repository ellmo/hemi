module Hemi::Event
  module KeyHandler
  private

    def handle_key
      case action = events[event.structize]
      when Symbol
        instance_eval action.to_s
      when Proc
        action.call
      end
    end

    def register_events!(events)
      @events = event_hash(events)
    end

    def event_hash(events)
      events.each_with_object({}) do |(input, action), hsh|
        key, mods = if input.is_a? Array
                      [input.shift, input]
                    else
                      input
                    end

        hsh[Hemi::Event::Pattern::Key.new(key, mods: mods)] = action
      end
    end
  end
end
