vows = require 'vows'
assert = require 'assert'
Todo = require '../lib/todo'
util = require 'util'

vows
  .describe('todo')
  .addBatch
    'a newly created todo':
      topic: new Todo('foobar')

      'has a text attribute': (topic) ->
        assert.equal topic.text, 'foobar'

      'is not done by default': (topic) ->
        assert.equal topic.done, false

    'a todo that is marked as done':
      topic: new Todo('foobar').do()

      'has an x prepended to it': (topic) ->
        assert.equal topic.text, 'x foobar'

    'a todo that is marked as undone':
      topic: new Todo('x foobar').undo()

      'has the x removed': (topic) ->
        assert.equal topic.text, 'foobar'

    'a todo with a priority':
      topic: new Todo('foobar').set_priority('A')

      'has the priority prepended in parentheses': (topic) ->
        assert.equal topic.text, '(A) foobar'

    'a todo with a priority that is marked as done':
      topic: new Todo('(A) foobar').do()

      'has the priority removed': (topic) ->
        assert.equal topic.text, 'x foobar'

    'a todo with the priority set to null':
      topic: new Todo('(A) foobar').set_priority(null)

      "doesn't have the parentheses": (topic) ->
        assert.equal topic.text, 'foobar'

    'a todo with the priority changed':
      topic: new Todo('(A) foobar').set_priority('B')

      'has the new priority in the text': (topic) ->
        assert.equal topic.text, '(B) foobar'

    'a todo with some text prepended to it':
      topic: new Todo('(A) foobar').prepend('baz baz')

      'has the text inserted after the priority': (topic) ->
        assert.equal topic.text, '(A) baz baz foobar'

    'a todo with some text appended to it':
      topic: new Todo('(A) foobar').append('lur lur')

      'has the text inserted at the end': (topic) ->
        assert.equal topic.text, '(A) foobar lur lur'

  .export(module)
