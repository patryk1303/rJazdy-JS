var gulp = require('gulp');
var gutil = require('gulp-util');
var bower = require('bower');
var concat = require('gulp-concat');
var sass = require('gulp-sass');
var minifyCss = require('gulp-minify-css');
var rename = require('gulp-rename');
var sh = require('shelljs');

//static
var EXPRESS_PORT = 4000;
var EXPRESS_ROOT = __dirname+'/www';
var LIVERELOAD_PORT = 35729;

var paths = {
  sass: ['./scss/**/*.scss']
};

gulp.task('default', ['sass','server']);

gulp.task('sass', function(done) {
  gulp.src('./scss/ionic.app.scss')
    // .pipe(sass())
	.pipe(sass({errLogToConsole: true}))
    .pipe(gulp.dest('./www/css/'))
    .pipe(minifyCss({
      keepSpecialComments: 0
    }))
    .pipe(rename({ extname: '.min.css' }))
    .pipe(gulp.dest('./www/css/'))
    .on('end', done);
});

gulp.task('watch', function() {
  gulp.watch(paths.sass, ['sass']);
});

gulp.task('install', ['git-check'], function() {
  return bower.commands.install()
    .on('log', function(data) {
      gutil.log('bower', gutil.colors.cyan(data.id), data.message);
    });
});

gulp.task('git-check', function(done) {
  if (!sh.which('git')) {
    console.log(
      '  ' + gutil.colors.red('Git is not installed.'),
      '\n  Git, the version control system, is required to download Ionic.',
      '\n  Download git here:', gutil.colors.cyan('http://git-scm.com/downloads') + '.',
      '\n  Once git is installed, run \'' + gutil.colors.cyan('gulp install') + '\' again.'
    );
    process.exit(1);
  }
  done();
});

gulp.task('server', function() {
	startExpress();
	startLivereload();
	gulp.watch('www/*.html',notifyLivereload);
	gulp.watch('www/templates/*.html',notifyLivereload);
	gulp.watch('scss/*.scss',['sass']);
	gulp.watch('www/css/*.css',notifyLivereload);
	// gulp.watch('app/scripts/*.js',notifyLivereload);
});

//live reload
function startExpress() {
	var express = require('express');
	var app = express();
	app.use(require('connect-livereload')());
	app.use(express.static(EXPRESS_ROOT));
	app.listen(EXPRESS_PORT);
}

function startLivereload() {
	lr = require('tiny-lr')();
	lr.listen(LIVERELOAD_PORT);
}

function notifyLivereload (event) {
	var fileName = require('path').relative(EXPRESS_ROOT,event.path);
	lr.changed({
		body: {
			files: [fileName]
		}
	});
	console.log('changed file: ' + fileName);
}