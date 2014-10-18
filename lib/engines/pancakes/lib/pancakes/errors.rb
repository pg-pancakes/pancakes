module Pancakes
	module Errors

		class NoConnection < StandardError
			def initialize
				super "No connection was found! Try calling Pancakes::Database.connect first."
			end
		end

	end
end