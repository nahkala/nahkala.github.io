module.exports = (grunt) ->
	
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		
		assemble:
			options:
				assets: 'build/assets'
				layoutdir: 'src/templates/layouts'
				data: ['src/data/**/*.json']
				partials: ['src/templates/partials/**/*.hbs']
				layout: 'default.hbs'
				helpers: ['./src/templates/helpers/**/*.js']

			site:
				expand: true
				cwd: 'src/templates/pages/'
				src: ['**/*.hbs']
				dest: 'build/'

		copy:
			js:
				expand: true
				cwd: 'src/'
				src: ['js/vendor/*.*']
				dest: 'build/'

			css: 
				expand: true
				cwd: 'src/style/vendor'
				src: ['**/*']
				dest: 'build/css/'

			fonts:
				expand: true
				cwd: 'src/'
				src: ['fonts/**/*']
				dest: 'build/'

			favicons:
				expand: true
				cwd: 'src/favicons/'
				src: ['*']
				dest: 'build/'

			img:
				expand: true
				cwd: 'src/'
				src: ['img/**/*']
				dest: 'build/'

		concat:
			options:
				separator: ';'

			header:
				src: ['src/js/polyfills.js', 'src/js/polyfills/**/*.js']
				dest: 'build/js/header.js'

			components:
				src: ['src/js/components.js', 'src/js/components/**/*.js']
				dest: 'build/js/components.js'

			main:
				src: ['src/js/main.js', 'src/js/pages/**/*.js']
				dest: 'build/js/main.js'

		clean:
			build: ['build']

		cssmin:
			main:
				src: ['<%= sass.site.dest %>']
				dest: 'build/css/main.min.css'

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
				dest: 'build/css/main.css'

		uglify:
			options:
				banner: '/*! <%= pkg.name %> <%= grunt.template.today(\'dd-mm-yyyy\') %> */\n'

			components:
				src: ['<%= concat.components.dest %>']
				dest: 'build/js/components.min.js'

			main:
				src: ['<%= concat.main.dest %>']
				dest: 'build/js/main.min.js'

		watch:
			js:
				files: ['<%= jshint.files %>']
				tasks: ['js']
			html:
				files: ['src/templates/**/*.hbs']
				tasks: ['html']
			css:
				files: ['src/style/**/*.*']
				tasks: ['css']
			img:
				files: ['src/img/**/*.*']
				tasks: ['img']
			favicons:
				files: ['src/favicons/**/*.*']
				tasks: ['favicons']
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
	grunt.registerTask 'default', ['clean', 'jshint', 'concat', 'uglify', 'sass',  'cssmin', 'newer:assemble', 'copy']

	# Register main tasks
	grunt.registerTask 'build', ['clean', 'jshint', 'concat', 'uglify', 'sass',  'cssmin', 'assemble', 'copy']
	grunt.registerTask 'design', ['default', 'watch']

	# Register helper tasks
	grunt.registerTask 'css', ['sass',  'cssmin', 'copy:css']
	grunt.registerTask 'favicons', ['copy:favicons']
	grunt.registerTask 'html', ['assemble']
	grunt.registerTask 'img', ['copy:img']
	grunt.registerTask 'js', ['jshint', 'concat', 'uglify', 'copy:js']
