# pretty much verbatim from https://github.com/twilson63/cakefile-template/blob/master/Cakefile
fs = require 'fs'
{print} = require 'util'
{spawn, exec} = require 'child_process'

log = (message, explanation) ->
  console.log message + ' ' + (explanation or '')

build = (watch, callback) ->
  if typeof watch is 'function'
    callback = watch
    watch = false
  options = ['-c', '-o', 'lib', 'src']
  options.unshift '-w' if watch

  coffee = spawn 'coffee', options
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> log data.toString()
  coffee.on 'exit', (status) -> callback?() if status is 0

spec = (callback) ->
  options = ['spec', '--coffee']
  spec = spawn 'jasmine-node', options
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> log data.toString()
  coffee.on 'exit', (status) -> callback?() if status is 0

task 'build', ->
  build -> log ":)"

task 'spec', 'Run Jasmine-Node', ->
  build -> spec -> log ':)'
