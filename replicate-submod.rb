#!/usr/bin/env ruby
#require 'optparse'
require 'fileutils'

#options = {}
#
#optparse = OptionParser.new do|opts|
#  opts.banner = "Usage: optparse1.rb [options] file1 file2 ..."
#  oldModule = nil
#  newModule = nil
#  opts.on('-m', '--module', 'Specify module name') do |module|
#    oldModule = module
#  end
#  opts.on('-n', '--new_module', 'Specify new module name') do |newModule|
#    newModule = newName 
#  end
#  opts.on('-h', '--help', 'Display this screen' ) do
#    puts opts
#    exit
#  end
#end
#
#optparse.parse!

oldModule = ARGV[0]
newModule = ARGV[1]

if oldModule.nil?
  puts('Old module name is nil')
  exit
end

if newModule.nil?
  puts('New module name is nil')
  exit
end

if !Dir.exists?(oldModule)
  puts "Old module directory does not exist"
end

puts "Copying " + oldModule + " to " + newModule + "..."
FileUtils.cp_r oldModule, newModule 
puts "Deleting target folder..."
targetFolder = newModule + "/target"
FileUtils.rm_rf(targetFolder)
oldIml = newModule + "/" + oldModule + ".iml"
FileUtils.rm_rf(oldIml)

# Not suitable for production code as data loss can occur
puts "Replacing old module name in pom.xml..."
pomFile = newModule + "/pom.xml"
text = File.read(pomFile)
new_contents = text.gsub(oldModule, newModule)
File.open(pomFile, "w") {|file| file.puts new_contents }
