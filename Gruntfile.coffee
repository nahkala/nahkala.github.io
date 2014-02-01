module.exports = (grunt) ->
	
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		
		assemble:
			options:
				assets: './assets'
				layoutdir: 'src/templates/layouts'
				data: ['src/data/**/*.json']
				partials: ['src/templates/partials/**/*.hbs']
				layout: 'default.hbs'
				helpers: ['prettify','./src/templates/helpers/**/*.js']
				prettify: {
					brace_style: 'expand',
					indent_char: '	',
					indent_scripts: 'normal',
					preserve_newlines: true,
					indent: 1,
					condense: true,
					padcomments: false,
					wrap_line_length: 0
				}
			site:
				expand: true
				cwd: 'src/templates/pages/'
				src: ['**/*.hbs']
				dest: './'

		copy:
			js:
				expand: true
				cwd: 'src/'
				src: ['js/vendor/*.*']
				dest: './'

			css: 
				expand: true
				cwd: 'src/style/vendor'
				src: ['**/*']
				dest: './css/'

			fonts:
				expand: true
				cwd: 'src/'
				src: ['fonts/**/*']
				dest: './'

			favicons:
				expand: true
				cwd: 'src/favicons/'
				src: ['*']
				dest: './'

			img:
				expand: true
				cwd: 'src/'
				src: ['img/**/*']
				dest: './'

		concat:
			options:
				separator: ';'

			header:
				src: ['src/js/header.js', 'src/js/header/**/*.js']
				dest: './js/header.min.js'

			components:
				src: ['src/js/components.js', 'src/js/components/**/*.js']
				dest: './js/components.js'

			main:
				src: ['src/js/main.js', 'src/js/pages/**/*.js']
				dest: './js/main.js'

		clean:
			build: ['*','!src', '!Gruntfile.coffee', '!LICENSE', '!README.md', '!package.json', '!.git', '!.gitmodules', '!.git', '!node_modules']
			all: ['*','!src', '!Gruntfile.coffee', '!LICENSE', '!README.md', '!package.json', '!.git', '!.gitmodules', '!.git']

		cssmin:
			main:
				src: ['<%= sass.site.dest %>']
				dest: './css/main.min.css'

		jshint:
			files: ['src/**/*.js', 'test/**/*.js', '!**/vendor/**' , '!**/polyfills/**']
			options:				
				globals:
					jQuery: true
					console: true
					module: true
					document: true

		sass:
			site:
				src: 'src/style/main.scss'
				dest: './css/main.css'

		uglify:
			options:
				sourceMap: true
				banner: '/*! <%= pkg.name %> <%= grunt.template.today(\'dd-mm-yyyy\') %> */\n'

			components:
				src: ['<%= concat.components.dest %>']
				dest: './js/components.min.js'

			main:
				src: ['<%= concat.main.dest %>']
				dest: './js/main.min.js'

		watch:
			script:
				files: ['<%= jshint.files %>']
				tasks: ['script']
			markup:
				files: ['src/templates/**/*.hbs']
				tasks: ['markup']
			style:
				files: ['src/style/**/*.*']
				tasks: ['style']
			assets:
				files: ['src/img/**/*.*', 'src/favicons/**/*.*']
				tasks: ['assets']
			livereload:
				files: ['<%= copy.css.dest %>']
				options:
					livereload: true

	# Load tasks
	grunt.loadNpmTasks 'grunt-newer'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-contrib-jshint'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'assemble'

	# Register default task (runs when no task is specified)
	grunt.registerTask 'default', ['clean:build', 'jshint', 'concat', 'uglify', 'sass',  'cssmin', 'newer:assemble', 'copy']

	# Register main tasks
	grunt.registerTask 'build', ['clean:build', 'jshint', 'concat', 'uglify', 'sass',  'cssmin', 'assemble', 'copy']
	grunt.registerTask 'design', ['default', 'watch']

	# Register helper tasks
	grunt.registerTask 'assets', ['copy:img', 'copy:favicons', 'copy:fonts']
	grunt.registerTask 'markup', ['assemble']
	grunt.registerTask 'script', ['jshint', 'concat', 'uglify', 'copy:js']
	grunt.registerTask 'style', ['sass', 'cssmin', 'copy:css']

