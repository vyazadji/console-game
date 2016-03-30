assert = require "assert"
Number = require "../src/number"
Expression = require "../src/expression"
Operation = require "../src/operation"
Generator = require "../src/generator"

describe 'Test Generator', () ->
  gen = new Generator

  it 'Value of generated expressions should be valid',  () ->
    exp1 = gen.generate(1)
    assert.equal exp1.getValue(), exp1.print()

    for i in [2..30]
      exp = gen.generate(i)

      result = exp.getValue().toFixed(1)
      expect = eval(exp.print()).toFixed(1)

      assert.equal result, expect, "Value of Expression level " + i + " isn't valid. Value = " + exp.getValue() + " Print: " +  exp.print()

  it "Level 1 structure should be valid", () ->
    exp1 = gen.generate(1)
    s = exp1.print()
    assert /^(\d)+$/.test(s), "Expression '" + s + "' has wrong structure "

  it "Level 2 structure should be valid", () ->
    exp = gen.generate(2)
    s = exp.print()
    assert /^\(?((\d)+\s(\+|\-|\*|\/)\s(\d)+)\)?$/.test(s), "Expression '" + s + "' has wrong structure "

  it "Level 3 structure should be valid", () ->
    exp = gen.generate(3)
    s = exp.print()
    assert /^(\(*(\d)+\s(\+|\-|\*|\/)\s\(*(\d)+\)*\s(\+|\-|\*|\/)\s(\d)+\)*)?$/.test(s), "Expression '" + s + "' has wrong structure "

  describe 'Correct DIVISION', () ->
    n6 = new Number 6
    n2 = new Number 2
    n3 = new Number 3

    it "Doesn't hange operation if Expression is ok", () ->
      a = new Expression n6, n2, Operation.ADDITION #6 + 2
      b = new Expression n6, n2, Operation.SUBTRACTION # 6 -2

      exp = new Expression a, b, Operation.DIVISION

      assert.equal "(6 + 2) / (6 - 2)", exp.print()
      assert.equal 2, exp.getValue()

      exp = gen.correctExpresssionIfNeed exp

      assert.equal "(6 + 2) / (6 - 2)", exp.print()
      assert.equal 2, exp.getValue()


    it "Change operation if b is Expression and Operation is DIVISION", () ->
      exp2 = new Expression n6, n6, Operation.SUBTRACTION

      exp = new Expression n6, exp2, Operation.DIVISION

      assert.equal "6 / (6 - 6)", exp.print()
      assert.equal "Infinity", exp.getValue()

      exp = gen.correctExpresssionIfNeed exp

      assert exp.operation != Operation.DIVISION
      assert "Infinity" != exp.getValue()

    it "Change operation if a and b is Expression", () ->
      a = new Expression n6, n2, Operation.ADDITION #6 + 2
      b = new Expression n6, n3, Operation.SUBTRACTION #6 - 3

      exp = new Expression a, b, Operation.DIVISION

      assert.equal "(6 + 2) / (6 - 3)", exp.print()
      assert !gen.isInt exp.getValue(), "Value " + exp.getValue() + "should be integer"

      exp = gen.correctExpresssionIfNeed exp

      assert exp.operation != Operation.DIVISION, "Operation must be not Division"
      assert gen.isInt exp.getValue(), "Value should be integer"

    it "Change a if a is Number", () ->
      exp = new Expression n3, n6, Operation.DIVISION

      assert.equal "3 / 6", exp.print()
      assert !gen.isInt exp.getValue(), "Value " + exp.getValue() + "should not be integer"

      exp = gen.correctExpresssionIfNeed exp

      assert exp.operation == Operation.DIVISION, "Operation must be Division"
      assert gen.isInt exp.getValue(), "Value should be integer"

    it "Change b if b is Number (1)", () ->
      a = new Expression n6, n3, Operation.ADDITION #6 + 3

      exp = new Expression a, n2, Operation.DIVISION

      assert.equal "(6 + 3) / 2", exp.print()
      assert !gen.isInt exp.getValue(), "Value " + exp.getValue() + "should be integer"

      exp = gen.correctExpresssionIfNeed exp

      assert exp.operation == Operation.DIVISION, "Operation must be Division"
      assert gen.isInt exp.getValue(), "Value should be integer"

    it "Change b if b is Number (2)", () ->
      a = new Expression n6, n3, Operation.SUBTRACTION #6 - 3

      exp = new Expression a, n2, Operation.DIVISION

      assert.equal "(6 - 3) / 2", exp.print()
      assert !gen.isInt exp.getValue(), "Value " + exp.getValue() + "should be integer"

      exp = gen.correctExpresssionIfNeed exp

      assert exp.operation == Operation.DIVISION, "Operation must be Division"
      assert.equal "(6 - 3) / 1", exp.print()
      assert gen.isInt exp.getValue(), "Value should be integer"
