vows = require 'vows'
assert = require 'assert'
model = require '../lib/model'
util = require 'util'

vows
  .describe('model')
  .addBatch
    'a newly created todo':
      topic: new model.Todo('foobar')

      'has a text attribute': (topic) ->
        assert.equal topic.text, 'foobar'

      'is not done by default': (topic) ->
        assert.equal topic.done, false

    'a todo that is marked as done':
      topic: new model.Todo('foobar').do()

      'has an x prepended to it': (topic) ->
        assert.equal topic.text, 'x foobar'

    'a todo that is marked as undone':
      topic: new model.Todo('x foobar').undo()

      'has the x removed': (topic) ->
        assert.equal topic.text, 'foobar'

    'a todo with a priority':
      topic: new model.Todo('foobar').set_priority('A')

      'has the priority prepended in parentheses': (topic) ->
        assert.equal topic.text, '(A) foobar'

    'a todo with a priority that is marked as done':
      topic: new model.Todo('(A) foobar').do()

      'has the priority removed': (topic) ->
        assert.equal topic.text, 'x foobar'

    'a todo with the priority set to null':
      topic: new model.Todo('(A) foobar').set_priority(null)

      "doesn't have the parentheses": (topic) ->
        assert.equal topic.text, 'foobar'

    'a todo with the priority changed':
      topic: new model.Todo('(A) foobar').set_priority('B')

      'has the new priority in the text': (topic) ->
        assert.equal topic.text, '(B) foobar'

    'a todo with some text prepended to it':
      topic: new model.Todo('(A) foobar').prepend('baz baz')

      'has the text inserted after the priority': (topic) ->
        assert.equal topic.text, '(A) baz baz foobar'

    'a todo with some text appended to it':
      topic: new model.Todo('(A) foobar').append('lur lur')

      'has the text inserted at the end': (topic) ->
        assert.equal topic.text, '(A) foobar lur lur'

    'an empty todo model':
      topic: new model.Model
      
      'has a length of zero': (topic) ->
        assert.equal topic.length(), 0

      'returns an error when accessing elements': (topic) ->
        assert.equal topic.by_id(0) instanceof Error, true

    'with one element':
      topic: ->
        m = new model.Model
        m.add(new model.Todo('foobar'))
        m

      'has a length of one': (topic) ->
        assert.equal topic.length(), 1

      'returns the element when accessing it': (topic) ->
        assert.equal topic.by_id(0).text, 'foobar'

      'returns an error when accessing past the end': (topic) ->
        assert.equal topic.by_id(1) instanceof Error, true

    'with a few elements':
      topic: new model.Model()
        .add(new model.Todo("foo"))
        .add(new model.Todo("bar"))
        .add(new model.Todo("baz"))

      'can be iterated to yield the elements in order': (mdl) ->
        assert.deepEqual(mdl.by_id(i).text for i in [0..2], ['foo', 'bar', 'baz'])

  .export(module)
