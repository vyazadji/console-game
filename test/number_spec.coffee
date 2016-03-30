assert = require "assert"
Number = require "../src/number"

describe 'Test Number class', () ->
  it 'Number should get the value',  () ->
    n = 2
    exp = new Number n
    assert.equal n, exp.getValue()

  it 'Print the value',  () ->
    n = 2
    exp = new Number n
    assert.equal '2', exp.getValue()
