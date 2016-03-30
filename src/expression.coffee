Number = require "./number"
Operation = require "./operation"

module.exports = class Expression extends Number

  constructor: (@a, @b, @operation) ->

  getValue: ->
    switch @operation
      when Operation.ADDITION       then @a.getValue() + @b.getValue()
      when Operation.SUBTRACTION    then @a.getValue() - @b.getValue()
      when Operation.MULTIPLICATION then @a.getValue() * @b.getValue()
      when Operation.DIVISION       then @a.getValue() / @b.getValue()


  print: (operations) ->
    out = @a.print(rightOperation: @operation) + " " + @operation + " " + @b.print(leftOperation: @operation)
    out = "(#{out})" if @_useBrackets operations
    out

  _useBrackets: (operations) ->
    useBrackets = false
    return useBrackets if !operations
    return @_checkLeftOperation operations.leftOperation if operations.leftOperation
    return @_checkRightOperation operations.rightOperation if operations.rightOperation
    useBrackets

  _checkLeftOperation: (leftOperation) ->
    useBrackets = false

    if leftOperation != Operation.ADDITION
      useBrackets = true

    if leftOperation == Operation.MULTIPLICATION && @operation == Operation.MULTIPLICATION
      useBrackets = false

    useBrackets

  _checkRightOperation: (rightOperation) ->
    useBrackets = false

    if rightOperation == Operation.MULTIPLICATION || rightOperation == Operation.DIVISION
      useBrackets = true

    useBrackets

