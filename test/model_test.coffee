vows = require 'vows'
assert = require 'assert'
todo = require '../lib/todo'

vows
  .describe('a model')
  .addBatch
    'item':
      topic: new todo.Todo('foobar')

      'has a text attribute': (topic) ->
        assert.equal 'foobar', topic.text

      'is not done by default': (topic) ->
        assert.equal false, topic.done

  .addBatch
    'when empty':
      topic: new todo.Model
      
      'has a length of zero': (topic) ->
        assert.equal 0, topic.length()

      'returns an error when accessing elements': (topic) ->
        assert.equal true, topic.by_id(0) instanceof Error

    'with one element':
      topic: ->
        m = new todo.Model
        m.add(new todo.Todo('foobar'))
        m

      'has a length of one': (topic) ->
        assert.equal 1, topic.length()

      'returns the element when accessing it': (topic) ->
        assert.equal 'foobar', topic.by_id(0).text

      'returns an error when accessing past the end': (topic) ->
        assert.equal true, topic.by_id(1) instanceof Error


  .export(module)
