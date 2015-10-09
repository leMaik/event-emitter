# event-emitter
This is a tiny event emitter for JavaScript. You find a lot of these online, and
as I could not find one that would fit my needs (without having too many other
features), I made my own.

## Usage
### Inherit from `event-emitter`
In CoffeeScript, you can inherit from `event-emitter` like this.
```coffee
EventEmitter = require 'event-emitter'
class MyClass extends EventEmitter
  # ...
```

### Add the event handler to an existing object
If your object already exists or if you don't use CoffeeScript or can't or don't
want to inherit from `event-emitter`, you can add the functions to an existing
object.
```js
var EventEmitter = require('event-emitter');
var myObject = { property: 'a' };
EventEmitter.installOn(myObject); //returns myObject
```
This adds `on`, `off` and `trigger` to your object, overwriting existing
properties.

### Actually use the event emitter
*tl;dr: It works like every event emitter in JavaScript.*

* Add listeners with `.on('event name', handler)`
* Remove all event listeners for an event with `.off('event name')`
* Remove a specific event listener with `.off('event name', handler)`
* Remove all event listeners with `.off()`

## License
This library (if 30 lines of code are enough to even call it a "library") is
licensed under the WTFPL. Do what you want...
