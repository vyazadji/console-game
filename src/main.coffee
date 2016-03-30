path = require 'path'
program = require 'commander'
readline = require 'readline'
pkg = require path.join(__dirname, '../package.json')

Expression = require "./expression"
Number = require "./number"
Operation = require "./operation"
Generator = require "./generator"


EXAMPLES_COUNT = 10

program
  .version(pkg.version)
  .option('-l, --level <n>', 'Set level of the math expression. The allowed values 2-100', parseInt)
  .option('-e, --examples', "Show #{EXAMPLES_COUNT} random math expressions")

program.on '--help', () ->
  console.log('  Examples:')
  console.log('')
  console.log('    $ npm start -l 3')
  console.log('    $ npm start -e')
  console.log('    $ node ./main.js -level 2')
  console.log('')

program.parse(process.argv);

level = program.level

showExamples =  ->
  console.log "Show #{EXAMPLES_COUNT} random math expressions"
  for i in [1..EXAMPLES_COUNT]
    exp = gen.generate(i)
    console.log i + ":", exp.print(), "=", exp.getValue()


isLevelValid = (level) ->
  2 <= level <= 100


askExpression = (level) ->
  exp = gen.generate level

  rl = readline.createInterface(process.stdin, process.stdout)
  rl.setPrompt "Write the solution for this expression: \n" + exp.print() + " = "
  rl.prompt()
  rl.on(
    'line',
    (line) ->
      if parseInt(line) == parseInt(exp.getValue())
        console.log "Congratulate! The solution is correct!"
      else
        console.log "The solution is not correct :("
      rl.close()
  ).on 'close', askContinueGame()

askLevel = ->
  rl = readline.createInterface(process.stdin, process.stdout)
  rl.setPrompt "Please specify level (between 2-100):"
  rl.prompt()
  rl.on(
    'line',
    (line) ->
      if isLevelValid(line)
        level = parseInt(line)
        rl.close()
      else
        console.log "Value is not valid. Level should be between 2-100"
        rl.prompt()
  ).on('close', () ->
    askExpression(level)
  )

askContinueGame = ->
  rl = readline.createInterface(process.stdin, process.stdout)
  rl.setPrompt "Do you want to continue? (l - change the level) [Y/n/l]:"
  rl.prompt()
  rl.on(
    'line',
    (line) ->
      if line == "n"
        console.log ("Bye!")
        process.exit(0)
      else if line == "l"
        rl.close()
        askLevel()
      else
        rl.close()
        askExpression(level)
  )

console.log "-= Run the game =-"

gen = new Generator

if program.examples
  showExamples()
  process.exit(0)


if (!program.level)
  askLevel()

if program.level
  if isLevelValid parseInt(program.level)
    askExpression program.level
  else
    console.log "Level is not valid."
    askLevel()
