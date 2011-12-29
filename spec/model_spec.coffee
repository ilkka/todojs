Todo = require '../lib/todo'

describe 'model', ->
  it 'should exist', ->
    expect(Todo.Model).toBeDefined()

  it 'should be instantiable', ->
    expect(typeof new Todo.Model).toEqual('object')

  describe 'when empty', ->
    model = {}
    beforeEach ->
      model = new Todo.Model

    it 'should have a length of zero', ->
      expect(model.length()).toEqual(0)

    it 'should give an error when trying to access elements', ->
      expect(model.by_id(0) instanceof Error).toBeTruthy()

    describe 'after adding one element', ->
      beforeEach ->
        model.add('foobar')

      it 'should have a length of one', ->
        expect(model.length()).toEqual(1)

      it 'should give the element when accessing it', ->
        expect(model.by_id(0)).toEqual('foobar')

      it 'should give an error when accessing elements past the end', ->
        expect(model.by_id(1) instanceof Error).toBeTruthy()

    describe 'after adding some real todos', ->
      beforeEach ->
        model.add(new Todo.Todo(item)) for item in ['first', '(B) second', '(A) third']

      describe 'when marking an item as done', ->
        beforeEach ->
          model.by_id(1).do()

        it 'should remove the priority', ->
          expect(model.by_id(1).text).toNotMatch(/^\(B\)/)

        it 'should prepend "x "', ->
          expect(model.by_id(1).text).toEqual('x second')

        describe 'when marking an item as undone', ->
          beforeEach ->
            model.by_id(1).undo()

          it 'should remove the "x "', ->
            expect(model.by_id(1).text).toEqual('second')

      describe 'when changing a todo priority', ->
        beforeEach ->
          model.by_id(0).set_priority('C')
          model.by_id(1).set_priority('A')
          model.by_id(2).set_priority(null)

        it 'should prepend priority in parentheses if there was none', ->
          expect(model.by_id(0).text).toEqual('(C) first')

        it 'should change priority in parentheses if there was one', ->
          expect(model.by_id(1).text).toEqual('(A) second')

        it 'should remove priority if it is set to null', ->
          expect(model.by_id(2).text).toEqual('third')
