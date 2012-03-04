vows = require 'vows'
assert = require 'assert'
Todo = require '../lib/todo'
util = require 'util'

vows
  .describe('todo')
  .addBatch
    'a newly created todo':
      topic: new Todo('foobar')

      'has a text attribute': (todo) ->
        assert.equal todo.text, 'foobar'

      'is not done by default': (todo) ->
        assert.equal todo.done, false

      'has an ID attribute set to null': (todo) ->
        assert.isNull todo.id

    'a todo that is marked as done':
      topic:  new Todo('foobar').do()

      'has an x prepended to it': (todo) ->
        assert.equal todo.text, 'x foobar'

    'a todo that is marked as undone':
      topic:  new Todo('x foobar').undo()

      'has the x removed': (todo) ->
        assert.equal todo.text, 'foobar'

    'a todo with a priority':
      topic:  new Todo('foobar').set_priority('A')

      'has the priority prepended in parentheses': (todo) ->
        assert.equal todo.text, '(A) foobar'

    'a todo with a priority that is marked as done':
      topic:  new Todo('(A) foobar').do()

      'has the priority removed': (todo) ->
        assert.equal todo.text, 'x foobar'

    'a todo with the priority set to null':
      topic:  new Todo('(A) foobar').set_priority(null)

      "doesn't have the parentheses": (todo) ->
        assert.equal todo.text, 'foobar'

    'a todo with the priority changed':
      topic:  new Todo('(A) foobar').set_priority('B')

      'has the new priority in the text': (todo) ->
        assert.equal todo.text, '(B) foobar'

    'a todo with some text prepended to it':
      topic:  new Todo('(A) foobar').prepend('baz baz')

      'has the text inserted after the priority': (todo) ->
        assert.equal todo.text, '(A) baz baz foobar'

    'a todo with some text appended to it':
      topic:  new Todo('(A) foobar').append('lur lur')

      'has the text inserted at the end': (todo) ->
        assert.equal todo.text, '(A) foobar lur lur'

  .export(module)
