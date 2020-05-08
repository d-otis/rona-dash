require_relative './config/environment'

def reload!
	load_all './app'
end

task :console do
	Pry.start
end

task :atl do
	api = API.new.atl
end

