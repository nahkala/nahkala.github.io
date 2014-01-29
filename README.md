nahkala.github.io
=================
This is my portfolio site, I use it to track my projects and displaying some of my work.
Feel free to use it as a template for your own portfolio site. But please remember to replace all art.

Getting Started
---------------
This project requires you to have [Ruby](http://www.ruby-lang.org/en/downloads/), [Sass](http://sass-lang.com/download.html) and [Grunt](http://gruntjs.com/) installed.
 If you're on OS X or Linux you probably already have Ruby installed; Test it with your terminal by typing: 
```shell
ruby -v
```

When you've confirmed you have Ruby installed, install the sass gem:
```shell
gem install sass
```

This project was designed to work with Grunt 0.4.x. If you're still using grunt v0.3.x it's strongly recommended that [you upgrade](http://gruntjs.com/upgrading-from-0.3-to-0.4)

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to edit a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install all needed plugins with this command:

```shell
npm install
```

Once all plugins have been installed, you may build the project:

```shell
grunt build
```

Suggested Workflow
------------------
To make your life a bit easier there are a few grunt commands already set up.


```shell
grunt build
```
> builds the project pages, minifying files etc. this should be run before release.

```shell
grunt default
```
> or just `grunt` works as grunt build but is a little bit faster because it skips some minification and only rebuilds changed pages.

```shell
grunt design
```
> runs a `grunt default` and then watches files for changes and builds whatever is needed. Also tries to livereload any css changes. 

There is also separate tasks for `grunt assets`, `grunt markup`, `grunt script` and `grunt style` that  outputs the latest stuff from `src/`if you would need them.


Release History
---------------
 * 2013-12-01   v0.1.0	First public release