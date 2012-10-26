fs      = require 'fs'
path    = require 'path'
async   = require 'async'
{print} = require 'util'
{spawn} = require 'child_process'

testCodes  = []
baseDomQuery = 'jquery-1.8'

task 'build', 'Build all coffee files', ->
  _build()

task 'test', 'Run tests', ->
  _build -> _withDomLib baseDomQuery, _test

task 'test:jquery18', 'Run tests using jQuery 1.8', ->
  _build -> _withDomLib 'jquery-1.8', -> _test -> _withDomLib baseDomQuery

task 'test:jquery17', 'Run tests using jQuery 1.7', ->
  _build -> _withDomLib 'jquery-1.7', -> _test -> _withDomLib baseDomQuery

task 'test:zepto10', 'Run tests using Zepto 1.0', ->
  _build -> _withDomLib 'zepto-1.0', -> _test -> _withDomLib baseDomQuery

task 'test:all', 'Run tests using all DOM query library versions', ->
  try
    _build -> _withDomLib 'zepto-1.0', -> _test -> _withDomLib 'jquery-1.7', -> _test -> _withDomLib baseDomQuery, -> _test 
  catch error
    _withDomLib baseDomQuery

_build = (callback) ->
  builder = (src, dest) ->
    (callback) ->
      coffee = spawn 'coffee', ['-c', '-o', dest, src]
      coffee.stderr.on 'data', (data) -> process.stderr.write data.toString()
      coffee.stdout.on 'data', (data) -> print data.toString()
      coffee.on 'exit', (code) -> callback?(code,code)
  async.parallel [
    builder('src','lib'),
    builder('test/src','test/lib')
  ], (err, results) -> callback?() unless err

_test = (callback) ->
  testDir = 'test/cases'
  testFiles = (file for file in fs.readdirSync testDir when /.*\.html$/.test(file))
  remaining = testFiles.length
  for file in testFiles
    filePath = fs.realpathSync "#{testDir}/#{file}"
    mochaPhantomJS = spawn 'mocha-phantomjs', ['-R', 'dot', filePath]
    mochaPhantomJS.stdout.on 'data', (data) -> 
      print data.toString()
    mochaPhantomJS.on 'exit', (code) ->
      testCodes.push code
      callback?() if --remaining is 0
  _exitWithTestsCode()

_withDomLib = (library, callback) ->
  console.log "Using #{library} library..."
  process.chdir 'vendor'
  fs.unlinkSync 'dom-lib.js'
  fs.symlinkSync "#{library}.js", 'dom-lib.js'
  process.chdir '..'
  callback?()

_exitWithTestsCode = ->
  process.once 'exit', ->
    passed = testCodes.every (code) -> code is 0
    process.exit if passed then 0 else 1  
  _exitWithTestsCode = ->

