vows = require 'vows'
assert = require 'assert'
util = require 'util'
execFile = require('child_process').execFile

scriptfile = if process.platform is 'win32' then 'todo.bat' else 'todo'

vows
  .describe('the CLI')
  .addBatch
    'when listing todos':
      topic: ->
        execFile(scriptfile, ['ls'], {cwd: __dirname + '/../bin'}, @callback)
        return

      'should exit with code zero': (err, stdout, stderr) ->
        assert.isNull err

      'should output the todos': (err, stdout, stderr) ->
        assert.equal stdout, "eka\ntoka\nkolmas\n"

  .export(module)
