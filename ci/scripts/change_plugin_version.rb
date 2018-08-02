Dir.glob("lib/**/version.rb") do |search_file|
    file = File.open("#{search_file}", "r+")
    buffer = file.read.gsub("#{ARGV[0]}", "#{ARGV[1]}")
    file.rewind
    file.print buffer
    file.close
end