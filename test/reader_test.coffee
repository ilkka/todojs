vows = require 'vows'
assert = require 'assert'
temp = require 'temp'
fs = require 'fs'
util = require 'util'
path = require 'path'
reader = require '../lib/reader'
Model = require '../lib/model'

vows
  .describe('the todo reader')
  .addBatch
    'given we have a directory':
      topic: ->
        tempdir = temp.mkdirSync 'todojs'
        throw err if util.isError(tempdir)
        tempdir

      'when reading an empty todo file':
        topic: (tempdir) ->
          filepath = path.join tempdir, 'empty_todo_file.txt'
          fs.writeFileSync filepath, ''
          reader.read filepath, this.callback

        'the resulting model is empty': (err, mdl) ->
          assert.isNull err
          throw err if util.isError(err)
          assert.instanceOf mdl, Model
          assert.equal mdl.length(), 0

      'but when one todo is added':
        topic: (tempdir) ->
          filepath = path.join tempdir, 'todo_file_with_single_todo.txt'
          fs.writeFileSync filepath, '(C) A test todo +project1 @context2'
          reader.read filepath, this.callback

        'the model has one todo': (err, mdl) ->
          assert.equal mdl.length(), 1

        'and the todo is exactly like in the file': (err, mdl) ->
          assert.equal mdl.by_id(0).text, '(C) A test todo +project1 @context2'

      'if a non-existing file is read':
        topic: (tempdir) ->
          reader.read path.join(tempdir, 'does_not_exist.txt'), this.callback

        'an error is produced': (err, mdl) ->
          assert.isTrue util.isError(err)

  .export(module)

