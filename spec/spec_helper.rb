require 'pry'

ordered_directories = %w[libs helpers models **]
ordered_directories.each do |directory|
  Dir[Dir.pwd + "/app/#{directory}/*.rb"].each { |file| require file }
end
