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

      'the original model should have 3 items': (model) ->
        assert.equal model.length, 3

      'when filtering by a word':
        topic: (model) ->
          new Filter(model, 'first')

        'it should have a length': (filter) ->
          assert.notEqual typeof filter.length, "undefined"

        'the length should be the number of matched todos': (filter) ->
          assert.equal filter.length, 1

      'when filtering so that there are gaps':
        topic: (model) ->
          new Filter(model, '@ctx')

        'the IDs should be preserved': (filter) ->
          assert.equal filter.byId(2).text, '(D) second +proj @ctx'

  .export(module)
