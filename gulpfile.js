var gulp = require('gulp');
var gutil = require('gulp-util');
var sourcemaps = require('gulp-sourcemaps');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var browserify = require('browserify');
var babelify = require('babelify');
var coffeeify = require('coffeeify');
var less = require("gulp-less")
var uglify = require('gulp-uglify');

gulp.task('watch', function () {
  gulp.watch("./css/*.less", ["less"]);
  gulp.watch("./src/*.coffee", ["coffee"]);
});

gulp.task("less", function() {
  gulp.src('./css/*.less')
    .pipe(less())
    .on("error", function(err) {
      console.log(err);
    })
    .pipe(gulp.dest("./css"))
});

gulp.task('coffee', function () {
  browserify('./src/main.coffee', {
    debug: true,
    extensions: [".coffee"]
  })
    .transform(coffeeify)
    .bundle()
    .on('error', gutil.log.bind(gutil, 'Browserify Error'))
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(sourcemaps.init({loadMaps: true})) // loads map from browserify file
    .pipe(uglify())
    .pipe(sourcemaps.write('./')) // writes .map file
    .pipe(gulp.dest('./js')
  );
});

gulp.task('default',["watch"]);

