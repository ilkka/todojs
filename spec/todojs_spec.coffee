Todo = require '../lib/todo'

describe 'model', ->
  it 'should exist', ->
    expect(Todo.Model).toBeDefined()

  it 'should be instantiable', ->
    expect(typeof new Todo.Model).toEqual('object')
