assert = require "assert"
Number = require "../src/number"
Expression = require "../src/expression"
Operation = require "../src/operation"

describe 'Test Expression class', () ->
  a = new Number 6
  b = new Number 2

  describe 'Operations with numbers', () ->


    it 'Addition of numbers',  () ->
      exp = new Expression a, b, Operation.ADDITION
      assert.equal "6 + 2", exp.print()
      assert.equal 8, exp.getValue()

    it 'Subtraction of numbers',  () ->
      exp = new Expression a, b, Operation.SUBTRACTION
      assert.equal "6 - 2", exp.print()
      assert.equal 4, exp.getValue()

    it 'Multiplication of numbers',  () ->
      exp = new Expression a, b, Operation.MULTIPLICATION
      assert.equal "6 * 2", exp.print()
      assert.equal 12, exp.getValue()

    it 'Division of numbers',  () ->
      exp = new Expression a, b, Operation.DIVISION
      assert.equal "6 / 2", exp.print()
      assert.equal 3, exp.getValue()

  describe 'Operations with numbers & expressions', () ->
    it 'Addition of numbers and expression',  () ->
      exp1 = new Expression a, b, Operation.ADDITION

      exp2 = new Expression a, exp1, Operation.ADDITION
      assert.equal "6 + 2", exp1.print()
      assert.equal "6 + 6 + 2", exp2.print()

      assert.equal 14, exp2.getValue()

    it 'Subtraction of numbers and expression',  () ->
      exp1 = new Expression a, b, Operation.SUBTRACTION

      exp2 = new Expression a, exp1, Operation.SUBTRACTION

      assert.equal "6 - (6 - 2)", exp2.print()
      assert.equal 2, exp2.getValue()

    it 'Multiplication  of numbers and expression',  () ->
      exp1 = new Expression a, b, Operation.MULTIPLICATION

      exp2 = new Expression a, exp1, Operation.MULTIPLICATION

      assert.equal "6 * 6 * 2", exp2.print()
      assert.equal 72, exp2.getValue()

    it 'Division  of numbers and expression',  () ->
      exp1 = new Expression a, b, Operation.MULTIPLICATION #12

      exp2 = new Expression exp1, a, Operation.DIVISION

      assert.equal "(6 * 2) / 6", exp2.print()
      assert.equal 2, exp2.getValue()

  describe 'Operations with expressions', () ->
    it "Expressions with expressions", () ->
      exp1 = new Expression a, b, Operation.ADDITION # 6 + 2
      exp2 = new Expression a, b, Operation.SUBTRACTION # 6 -2

      exp3 = new Expression exp1, exp2, Operation.DIVISION


      assert.equal "(6 + 2) / (6 - 2)", exp3.print()
      assert.equal 2, exp3.getValue()

    it "No brackets for ADDITION ", () ->
      exp1 = new Expression a, b, Operation.ADDITION # 6 + 2
      exp2 = new Expression a, b, Operation.SUBTRACTION # 6 -2

      exp3 = new Expression exp1, exp2, Operation.ADDITION


      assert.equal "6 + 2 + 6 - 2", exp3.print()
      assert.equal 12, exp3.getValue()

    it "Add brackets for MULTIPLICATION ", () ->
      exp1 = new Expression a, b, Operation.ADDITION # 6 + 2
      exp2 = new Expression a, b, Operation.SUBTRACTION # 6 -2

      exp3 = new Expression exp1, exp2, Operation.MULTIPLICATION


      assert.equal "(6 + 2) * (6 - 2)", exp3.print()
      assert.equal 32, exp3.getValue()

    it "No brackets for left operation MULTIPLICATION ", () ->
      exp1 = new Expression a, b, Operation.MULTIPLICATION # 6 * 2
      exp2 = new Expression a, b, Operation.SUBTRACTION # 6 - 2

      exp3 = new Expression exp1, exp2, Operation.ADDITION


      assert.equal "6 * 2 + 6 - 2", exp3.print()
      assert.equal 16, exp3.getValue()

    it "No brackets for left operation DIVISION ", () ->
      exp1 = new Expression a, b, Operation.ADDITION # 6 + 2
      exp2 = new Expression a, b, Operation.DIVISION # 6 * 2

      exp3 = new Expression exp1, exp2, Operation.ADDITION


      assert.equal "6 + 2 + 6 / 2", exp3.print()
      assert.equal 11, exp3.getValue()
