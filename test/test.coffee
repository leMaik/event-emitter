test = require 'ava'
EventEmitter = require '../'

testEventCalled = (obj) ->
  called = false
  obj.on 'test', -> called = true
  obj.trigger 'test'
  return called

test 'it can be used with inheritance', (t) ->
  class Test extends EventEmitter
    constructor: ->

  t.assert testEventCalled new Test()
  t.end()

test 'it can be installed on objects', (t) ->
  obj = {}
  EventEmitter.installOn obj

  t.assert testEventCalled(obj)
  t.end()

test 'all event handlers of an event can be removed', (t) ->
  obj = {}
  EventEmitter.installOn obj
  called = false
  obj.on 'test', -> called = true
  obj.off 'test'

  obj.trigger 'test'
  t.assert !called
  t.end()

test 'all event handlers can be removed', (t) ->
  obj = {}
  EventEmitter.installOn obj
  calls = 0
  obj.on 'test', -> calls++
  obj.on 'test2', -> calls++
  obj.off()

  obj.trigger 'test'
  obj.trigger 'test2'
  t.assert calls == 0
  t.end()

test 'one event handler can be removed', (t) ->
  obj = {}
  EventEmitter.installOn obj
  called = false
  secondCalled = false
  setCalled = -> called = true
  obj.on 'test', setCalled
  obj.on 'test', -> secondCalled = true
  obj.off 'test', setCalled

  obj.trigger 'test'
  t.assert !called
  t.assert secondCalled
  t.end()

test 'multiple event handlers can be registered for an event', (t) ->
  obj = {}
  EventEmitter.installOn obj
  called = false
  secondCalled = false
  obj.on 'test', -> called = true
  obj.on 'test', -> secondCalled = true

  obj.trigger 'test'
  t.assert called
  t.assert secondCalled
  t.end()

test 'arguments are collected and passed to the event handler', (t) ->
  obj = {}
  EventEmitter.installOn obj
  obj.on 'test', (args) ->
    t.same args, ['a', 'b', 'c']

  obj.trigger 'test', 'a', 'b', 'c'
  t.end()

test 'it does not fail when triggering events without handlers', (t) ->
  obj = {}
  EventEmitter.installOn obj
  obj.trigger 'unknownEvent', 'some', 'arguments'
  t.end()

test 'it does not fail when removing handlers of an event that was never registered', (t) ->
  obj = {}
  EventEmitter.installOn obj
  obj.off 'unknownEvent'
  obj.off 'unknownEvent2', -> console.log 'handler'
  t.end()
