'use strict';

/**
* Set theme directory
*/

const themesFolder = 'web/themes';

// Set theme name to target the build 
const themeName = 'indigo';
const currentTheme = '/' + themeName + '/';

const path = {
  theme: themesFolder + currentTheme,
  build: 'build',
  less: 'less',
  css: 'css',
  js: 'js',
  img: 'img',
  templates: 'templates'
};

// Set paths
path.build = path.theme + path.build;
path.less = path.theme + path.less;
path.css = path.theme + path.css;
path.js = path.theme + path.js;
path.img = path.theme + path.img;
path.templates = path.theme + path.templates;

const gulp = require('gulp');
const less = require('gulp-less');
const lessGlob = require('gulp-less-glob');
const watch = require('gulp-watch');
const prefix = require('gulp-autoprefixer');
const plumber = require('gulp-plumber');
const cleanCSS = require('gulp-clean-css');
const babel = require('gulp-babel');
const browserify = require('gulp-browserify');
const sourcemaps = require('gulp-sourcemaps');
const browserSync = require('browser-sync').create();
const htmlInjector = require('bs-html-injector');
const reload = browserSync.reload;
const buildDir = path.build;

// Set Project Domain to proxy:
const proxyDomain = 'localhost:8090';

function buildStyles() {
  return gulp
    .src(path.less + '/style.less') // only compile the entry file
    .pipe(lessGlob())
    .pipe(plumber())
    .pipe(
      less({
        paths: [path.less + '/*/*']
      })
    )
    .pipe(prefix('last 4 versions', '> 1%', 'ie 11', 'ios 7'))
    .pipe(plumber.stop())
    .pipe(
      cleanCSS({
        advanced: false,
        agressiveMerging: false,
        compatibility: 'ie11',
        processImport: false
      })
    )
    .pipe(gulp.dest(buildDir))
    .pipe(reload({ stream: true }));
}

function buildScripts() {
  return gulp
    .src(path.js + '/script.js')
    .pipe(sourcemaps.init())
    .pipe(babel())
    .pipe(browserify({ transform: ['babelify'] }))
    .pipe(gulp.dest(buildDir))
    .pipe(reload({ stream: true }));
}

function syncBrowsers() {
  browserSync.use(htmlInjector, {});

  return browserSync.init({
    proxy: proxyDomain,
    open: false,
    port: 8091,
    ui: {
      port: 8092
    }
  });
}

function watchFiles() {
  watch([path.less + '/**/*.less'], buildStyles, htmlInjector);
  watch([path.js + '/*.js'], buildScripts, htmlInjector);
  watch([path.js + '/*.js']).on('change', reload);
  watch([path.templates + '/**/*.twig', path.theme + themeName + '.theme'], htmlInjector);
  watch(path.theme + themeName + '.theme').on('change', reload);
}

exports.buildStyles = buildStyles;
exports.buildScripts = buildScripts;
exports.syncBrowsers = syncBrowsers;
exports.watchFiles = watchFiles;
exports.serve = gulp.parallel(buildStyles, buildScripts, syncBrowsers, watchFiles);
