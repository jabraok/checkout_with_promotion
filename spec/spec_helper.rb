require 'pry'

ordered_directories = %w[models promotions **]
ordered_directories.each do |directory|
  Dir[Dir.pwd + "/app/#{directory}/**/*.rb"].each { |file| require file }
end
