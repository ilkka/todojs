vows = require 'vows'
assert = require 'assert'
temp = require 'temp'
fs = require 'fs'
util = require 'util'
path = require 'path'
reader = require '../lib/reader'
model = require '../lib/model'

vows
  .describe('the todo reader')
  .addBatch
    'an empty todo file':
      topic: ->
        tempdir = temp.mkdirSync 'todojs'
        throw err if util.isError(tempdir)
        filepath = path.join tempdir, 'empty_todo_file.txt'
        fs.writeFileSync filepath, ''
        filepath

      'when read':
        topic: (filepath) ->
          reader.read filepath, this.callback

        'should produce an empty model': (err, mdl) ->
          assert.isNull err
          throw err if util.isError(err)
          assert.instanceOf mdl, model.Model
          assert.equal mdl.length(), 0

  .export(module)

