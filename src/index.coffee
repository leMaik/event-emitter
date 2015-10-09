class EventEmitter
  on: (eventName, listeners...) ->
    @_events or= []
    handlers = @_events[eventName] or= []
    for l in listeners when l not in handlers
      handlers.push l
    return this

  off: (eventName, listeners...) ->
    return if not @_events
    if eventName
      return if not @_events[eventName]
      if listeners.length > 0
        @_events[eventName] = @_events[eventName].filter (h) -> h not in listeners
      else
        @_events[eventName] = []
    else
      @_events = []

  trigger: (eventName, args...) ->
    if @_events and @_events[eventName]
      handler(args) for handler in @_events[eventName]

EventEmitter.installOn = (object) ->
  emitter = new EventEmitter()
  object.on = emitter.on
  object.off = emitter.off
  object.trigger = emitter.trigger
  return object

module.exports = EventEmitter
