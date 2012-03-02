vows = require 'vows'
assert = require 'assert'
Model = require '../lib/model'
Todo = require '../lib/todo'
util = require 'util'

vows
  .describe('model')
  .addBatch
    'an empty todo model':
      topic: new Model
      
      'has a length of zero': (topic) ->
        assert.equal topic.length(), 0

      'returns an error when accessing elements': (topic) ->
        assert.equal topic.by_id(0) instanceof Error, true

    'with one element':
      topic: ->
        m = new Model
        m.add(new Todo('foobar'))
        m

      'has a length of one': (topic) ->
        assert.equal topic.length(), 1

      'returns the element when accessing it': (topic) ->
        assert.equal topic.by_id(0).text, 'foobar'

      'returns an error when accessing past the end': (topic) ->
        assert.equal topic.by_id(1) instanceof Error, true

    'with a few elements':
      topic: new Model()
        .add(new Todo("foo"))
        .add(new Todo("bar"))
        .add(new Todo("baz"))

      'can be iterated to yield the elements in order': (mdl) ->
        assert.deepEqual(mdl.by_id(i).text for i in [0..2], ['foo', 'bar', 'baz'])

  .export(module)
