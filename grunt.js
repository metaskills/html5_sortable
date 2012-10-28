
spawn = require('child_process').spawn;

module.exports = function(grunt) {

  grunt.initConfig({
    cake: {
      test: {}
    },
    watch: {
      files: '**/*.coffee',
      tasks: ['cake:test:all']
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerMultiTask('cake', 'Test with Cakefile.', function(){
    var args = this.nameArgs.split(':');
    var testArg = args.slice(1, args.length).join(':');
    var done = this.async();
    var cakeTest = spawn('cake', [testArg]);
    cakeTest.stdout.on('data', function(data){ grunt.log.write(data.toString()); })
    cakeTest.on('exit', function(code){ done(code); })
  });

  grunt.registerTask('default', 'watch');

};
