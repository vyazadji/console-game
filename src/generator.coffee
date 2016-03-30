Number = require "./number"
Expression = require "./expression"
Operation = require "./operation"

module.exports = class Generator

  config:
    max: 100
    min: 1

  constructor: (@max = @config.max, @min = @config.min) ->

  generate: (level) ->
    if level > 2
      atoms = @_getAtoms level

      exp = @generate atoms[0]

      if atoms[1] > 0
        exp2 = @generate atoms[1]

        exp = @createExpression exp, exp2
    else
      exp = @_buildExpresions(level)

    exp


  _buildExpresions: (level) ->
    exp = @createNumber()
    while level > 1
      exp = @createExpression exp
      level--

    exp

  _getAtoms: (level) ->
    random = @_getRandomNumber(level - 1, 0)

    [level - random, random]

  createNumber: (n = @._getRandomNumber()) ->
    new Number(n)

  createExpression: (a = @createNumber(), b = @createNumber(), operation = @_getRandomOperation()) ->
    exp = new Expression a, b, operation
    @correctExpresssionIfNeed exp


  correctExpresssionIfNeed: (exp) ->
    if @isInt exp.getValue()
      return exp

    #try to correct
    valueAabs = Math.abs exp.a.getValue()
    valueBabs = Math.abs exp.b.getValue()

    #b == 0
    if valueBabs == 0 && !@isNumber(exp.b)
      newExp = @_changeOperationWithouDivision exp
      return  newExp

    #correct a
    if @isNumber(exp.a) && valueBabs < (@max / 2)
      correctValueA = @_correctNumberAForDivision(valueBabs)
      exp.a = @createNumber correctValueA
      return exp

    #correct b
    if @isNumber(exp.b) && !@isNumber(exp.a)
      correctValueB = @_correctNumberBForDivision(valueAabs )
      exp.b = @createNumber correctValueB
      return exp

    @_changeOperationWithouDivision exp


  _correctNumberAForDivision: (valueB) ->
    maxMultiplier = parseInt @max / valueB
    randomMultiplier = @_getRandomNumber maxMultiplier
    valueB * randomMultiplier


  _correctNumberBForDivision: (valueA) ->
    maxDivider = parseInt valueA / 2

    maxDivider = @max if maxDivider > @max

    divider = @_getRandomNumber(maxDivider)

    divider = 1 if divider < 1

    while valueA % divider != 0
      divider--

    divider



  _changeOperationWithouDivision: (exp) ->
    newOperation = @_getRandomOperationNoDivision()
    exp.operation = newOperation
    exp

  isNumber: (exp) ->
    exp.constructor.name == Number.name

  isInt: (n) ->
    n % 1 == 0


  #min included
  #max included
  _getRandomNumber: (max = @max, min = @min) ->
    max++
    Math.floor(Math.random() * (max - min) + min)


  _getRandomOperationNoDivision: ->
    @_getRandomOperation Object.keys(Operation).length - 1

  _getRandomOperation: (n = Object.keys(Operation).length) ->
    switch @._getRandomNumber(n)
      when 1 then Operation.ADDITION
      when 2 then Operation.SUBTRACTION
      when 3 then Operation.MULTIPLICATION
      when 4 then Operation.DIVISION
