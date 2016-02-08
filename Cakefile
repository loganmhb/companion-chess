fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'

build = (callback) ->
  coffee = spawn 'coffee', ['-c', '-o', 'www/js', 'src']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

task 'build', 'Build www/js/ from src/', ->
  build()

task 'watch', 'Watch src/ for changes', ->
    coffee = spawn 'coffee', ['-w', '-c', '-o', 'www/js', 'src']
    coffee.stderr.on 'data', (data) ->
      process.stderr.write data.toString()
    coffee.stdout.on 'data', (data) ->
      print data.toString()

task 'serve', 'Start a webserver', ->
  # First serve, then watch
  spawn './serve', './www'
  invoke 'watch'
