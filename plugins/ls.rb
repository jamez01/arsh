# ls.rb v0.1.0
# ls.rb - A partial implentation of ls all written in ruby.
#
# This example shows how easy it is to create a plugin for arsh.

# The ArshCommands module holds all internal commands.
module ArshCommands
  def self.lsa(args = "")
  directories = Dir.entries("#{Dir.pwd}").sort
    directories.delete_if { |x| x =~ /^\./ unless args.include?("-a") }
    directories.map! { |x| "#{("0x"+File.stat(x).mode.to_s)} #{File.stat(x).uid} #{File.stat(x).gid} #{File.stat(x).mtime} #{x} "} if args.include?("-l")
     return directories
    end
  def self.lsx(args) # Each command is a method.
    puts self.lsa(args)
  end
end
