# Export Plugin
module.exports = (BasePlugin) ->
	# Define Plugin
	class LivescriptPlugin extends BasePlugin
		# Plugin name
		name: 'livescript'

		# Plugin config
		config:
			compileOptions: {}

		# Render
		# Called per document, for each extension conversion. Used to render one extension to another.
		render: (opts) ->
			# Prepare
			{inExtension,outExtension,file} = opts

			# LiveScript to JavaScript
			if inExtension in ['ls'] and outExtension in ['js',null]
				# Prepare
				livescript = require('LiveScript')
				fileFullPath = file.get('fullPath')
				compileOptions = {
					filename: fileFullPath
				}

				# Merge options
				for own key,value of @getConfig().compileOptions
					compileOptions[key] ?= value

				# Render
				opts.content = livescript.compile(opts.content, compileOptions)

			# Done
			return