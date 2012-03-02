vows = require 'vows'
assert = require 'assert'
Model = require '../lib/model'
Todo = require '../lib/todo'
Filter = require '../lib/filter'
util = require 'util'

vows
  .describe('filter')
  .addBatch
    'given we have a model with some todos':
      topic: ->
        m = new Model
        m.add(new Todo(t)) for t in [
          '(A) first', '(D) second +proj @ctx', '(B) @ctx third'
        ]
        m

      'when filtering by a word':
        topic: (m) ->
          new Filter(m, 'first')

        'it should have a length': (filter) ->
          assert.notEqual typeof filter.length, "undefined"

  .export(module)
