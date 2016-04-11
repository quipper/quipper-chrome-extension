gulp = require('gulp')
browserify = require('browserify')
buffer = require('vinyl-buffer')
source = require('vinyl-source-stream')
through = require('through2')
uglify = require('gulp-uglify')
concat = require('gulp-concat')
clean = require('gulp-clean')
plumber = require('gulp-plumber')
es = require('event-stream')
sass = require('gulp-sass')


gulp.task 'default', ['build'], ->
  gulp.watch(['src/**/*.{html,json,png,jpg,gif,svg,js}'], ['copy'])
  gulp.watch(['src/**/*.css'], ['css'])
  gulp.watch(['src/**/*.{coffee,hbs}'], ['browserify'])

gulp.task 'build', ['browserify', 'css', 'copy']

gulp.task 'browserify', ['clean:browserify'], ->
  files = [
    output: 'popup.js'
    entry: './src/coffee/popup.coffee'
  ,
    output: 'background.js'
    entry: './src/coffee/background.coffee'
  ]

  tasks = files.map (obj) ->
    bundledStream = through()

    bundledStream
      .pipe source(obj.output)
      .pipe plumber()
      .pipe buffer()
      #.pipe uglify()
      .pipe gulp.dest('./dist/')

    browserify
        entries: [obj.entry]
        debug: true
      .bundle()
      .on 'error', (err) ->
        console.log(err.stack)
      .pipe(bundledStream)

    bundledStream

  es.merge.apply(null, tasks)

gulp.task 'css', ['clean:css'], ->
  gulp.src('./src/css/popup.scss')
    .pipe sass().on('error', sass.logError)
    .pipe gulp.dest('./dist')

  gulp.src 'src/css/**/*.css'
    .pipe plumber()
    .pipe concat "popup.css"
    .pipe gulp.dest './dist'

gulp.task 'copy', ['clean:copy'], ->
  gulp.src ['src/html/**/*.html', 'src/manifest.json', 'src/img/**/*.{png,jpg,gif,svg}', 'src/js/*.js']
    .pipe plumber()
    .pipe gulp.dest './dist'

gulp.task 'clean:browserify', ->
  gulp.src ['./dist/popup.js', './dist/background.js'], read: false
    .pipe plumber()
    .pipe clean()

gulp.task 'clean:css', ->
  gulp.src './dist/*.css', read: false
    .pipe plumber()
    .pipe clean()

gulp.task 'clean:copy', ->
  gulp.src ['./dist/*.{html,json,png,jpg,gif,svg}'], read: false
    .pipe plumber()
    .pipe clean()
