fs      = require 'fs'
path    = require 'path'
async   = require 'async'
{print} = require 'util'
{spawn} = require 'child_process'

testCodes  = []
baseDomQuery = 'jquery-1.8'

task 'build', 'Build all coffee files', ->
  build()

task 'test', 'Run tests', ->
  build -> withDomLib baseDomQuery, test

task 'test:jquery18', 'Run tests using jQuery 1.8', ->
  build -> withDomLib 'jquery-1.8', test -> withDomLib baseDomQuery

task 'test:jquery17', 'Run tests using jQuery 1.7', ->
  build -> withDomLib 'jquery-1.7', test -> withDomLib baseDomQuery

task 'test:zepto10', 'Run tests using Zepto 1.0', ->
  build -> withDomLib 'zepto-1.0', test -> withDomLib baseDomQuery

task 'test:all', 'Run tests using all DOM query library versions', ->
  try
    build -> withDomLib 'jquery-1.8', test -> withDomLib 'jquery-1.7', test -> withDomLib 'zepto-1.0', test -> withDomLib baseDomQuery
  catch error
    withDomLib baseDomQuery

build = (callback) ->
  b = (src, dest) ->
    (callback) ->
      coffee = spawn 'coffee', ['-c', '-o', dest, src]
      coffee.stderr.on 'data', (data) -> process.stderr.write data.toString()
      coffee.stdout.on 'data', (data) -> print data.toString()
      coffee.on 'exit', (code) -> callback?(code,code)
  async.series [
    b('src','lib'),
    b('test/src','test/lib')
  ], callback

test = (callback) ->
  testDir = './test'
  testFiles = (file for file in fs.readdirSync testDir when /.*\.html$/.test(file))
  remaining = testFiles.length
  for file in testFiles
    filePath = fs.realpathSync "#{testDir}/#{file}"
    phantomjs = spawn 'phantomjs', ['test/lib/run-jasmine.phantom.js', "file://#{filePath}"]
    phantomjs.stdout.on 'data', (data) -> 
      print data.toString()
    phantomjs.on 'exit', (code) ->
      testCodes.push code
      callback?() if --remaining is 0
  exitWithTestsCode()

withDomLib = (library, callback) ->
  console.log "Using #{library} library..."
  process.chdir 'vendor'
  fs.unlinkSync 'dom-lib.js'
  fs.symlinkSync "#{library}.js", 'dom-lib.js'
  process.chdir '../..'
  callback?()

exitWithTestsCode = ->
  process.once 'exit', ->
    passed = testCodes.every (code) -> code is 0
    process.exit if passed then 0 else 1  
  exitWithTestsCode = ->

