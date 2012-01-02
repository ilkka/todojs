vows = require 'vows'
assert = require 'assert'
todo = require '../lib/todo'
temp = require 'temp'
fs = require 'fs'
util = require 'util'
path = require 'path'
reader = require '../lib/reader'
model = require '../lib/model'

temp.mkdir 'todojs', (err,tempdir) ->
  if err throw err
  vows
    .describe('the todo reader')
    .addBatch
      'when reading an empty todo file':
        topic: ->
          filepath = path.join tempdir, 'empty_todo_file.txt'
          fs.writeFileSync filepath, ''
          reader.read 'filepath'

        'reading that should produce an empty model': (topic) ->
          assert.instanceOf topic, model.Model
    .export(module)

