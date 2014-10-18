module Pancakes
	module Database

		def self.connect *args
			options ||= {}
			options.merge(args.extract_options!)
			raise Pancakes::Errors::NoConnection.new unless Pancakes.connection
			
		end

	end
end