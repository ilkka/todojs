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
        assert.equal topic.length, 0

      'returns an error when accessing elements': (topic) ->
        assert.equal topic.byId(1) instanceof Error, true

    'with one element':
      topic: ->
        m = new Model
        m.add(new Todo('foobar'))
        m

      'has a length of one': (topic) ->
        assert.equal topic.length, 1

      'assigns IDs to elements starting from one': (topic) ->
        assert.isFalse topic.byId(1) instanceof Error
        assert.equal topic.byId(1).text, 'foobar'

      'returns an error when accessing past the end': (topic) ->
        assert.equal topic.byId(2) instanceof Error, true

    'with a few elements':
      topic: new Model()
        .add(new Todo("foo"))
        .add(new Todo("bar"))
        .add(new Todo("baz"))

      'gives IDs to todos in the order they are added': (mdl) ->
        assert.deepEqual(mdl.byId(i).text for i in [1..3], ['foo', 'bar', 'baz'])

  .export(module)
