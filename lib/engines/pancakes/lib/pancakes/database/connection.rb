module Pancakes
	module Database

		def self.connect *args
			options ||= {}
			options.merge(args.extract_options!)
		end

	end
end