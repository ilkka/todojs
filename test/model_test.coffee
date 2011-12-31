vows = require 'vows'
assert = require 'assert'
todo = require '../lib/todo'

vows
  .describe('a model')
  .addBatch
    'a todo item':
      topic: new todo.Todo('foobar')

      'has a text attribute': (topic) ->
        assert.equal topic.text, 'foobar'

      'is not done by default': (topic) ->
        assert.equal topic.done, false

    'a todo that is marked as done':
      topic: new todo.Todo('foobar').do()

      'has an x prepended to it': (topic) ->
        assert.equal topic.text, 'x foobar'

    'a todo that is marked as undone':
      topic: new todo.Todo('x foobar').undo()

      'has the x removed': (topic) ->
        assert.equal topic.text, 'foobar'

    'a todo with a priority':
      topic: new todo.Todo('foobar').set_priority('A')

      'has the priority prepended in parentheses': (topic) ->
        assert.equal topic.text, '(A) foobar'

    'a todo with a priority that is marked as done':
      topic: new todo.Todo('(A) foobar').do()

      'has the priority removed': (topic) ->
        assert.equal topic.text, 'x foobar'

    'a todo with the priority set to null':
      topic: new todo.Todo('(A) foobar').set_priority(null)

      "doesn't have the parentheses": (topic) ->
        assert.equal topic.text, 'foobar'

    'a todo with the priority changed':
      topic: new todo.Todo('(A) foobar').set_priority('B')

      'has the new priority in the text': (topic) ->
        assert.equal topic.text, '(B) foobar'

    'a todo with some text prepended to it':
      topic: new todo.Todo('(A) foobar').prepend('baz baz')

      'has the text inserted after the priority': (topic) ->
        assert.equal topic.text, '(A) baz baz foobar'

    'a todo with some text appended to it':
      topic: new todo.Todo('(A) foobar').append('lur lur')

      'has the text inserted at the end': (topic) ->
        assert.equal topic.text, '(A) foobar lur lur'

  .addBatch
    'an empty todo model':
      topic: new todo.Model
      
      'has a length of zero': (topic) ->
        assert.equal topic.length(), 0

      'returns an error when accessing elements': (topic) ->
        assert.equal topic.by_id(0) instanceof Error, true

    'with one element':
      topic: ->
        m = new todo.Model
        m.add(new todo.Todo('foobar'))
        m

      'has a length of one': (topic) ->
        assert.equal topic.length(), 1

      'returns the element when accessing it': (topic) ->
        assert.equal topic.by_id(0).text, 'foobar'

      'returns an error when accessing past the end': (topic) ->
        assert.equal topic.by_id(1) instanceof Error, true

  .export(module)
