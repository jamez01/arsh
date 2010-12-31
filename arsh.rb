#!/usr/bin/ruby
ARSH_INSTALL_PATH="."
require 'readline'
Dir.glob("#{ARSH_INSTALL_PATH}/libs/*.rb").each { |mod| load(mod) }
 trap('QUIT',"IGNORE")
 trap('INT') { begin
  break
  rescue
  print "^C"
  end
  }
## Set up some default variables
$ps1="(arsh)<% ENV['USER'] %>@<% Dir.pwd %>$ "
$ps2=">"
## Setup readline's completeion
  Readline.completion_append_character =  nil
  Readline.completion_proc = proc do |prefix|
    # Complete files and directories
    files = Dir["#{File.expand_path(prefix)}*"]
    files.map { |f| File.expand_path(f) }.map { |f| File.directory?(f) ? f + "/" : f }
    # Complete programs and files within the path.
    ENV['PATH'].split(":").each { |path| Dir.entries(path).each { |prog| files << prog if prog =~ /^#{prefix}/  } }
    # Complete builtin methods
    ArshCommands.singleton_methods.each { |file| files << file if file =~ /^#{prefix}/ }
    files.uniq
  end

# Builtin commands

module ArshCommands
  INTHIST = Array.new
  def internal_history
    @internal_history
  end
  def internal_history=(input)
    @internal_history << input
  end
  # Exit with exit code.
  def self.exit(code)
   Kernel.exit(code.to_s.to_i)
  end

  # Change directory
  def self.cd(dir)
    dir = ["#{ENV['HOME']}"] if dir.nitems == 0
    if File.directory?(File.expand_path(dir.join(" "))) then Dir.chdir(File.expand_path(dir.join(" "))) else puts "Invalid Directory #{dir.to_s}" end
  end

  # Determine if a file is included in the path.
  def self.in_path?(cmd,parms)
   ENV['PATH'].split(/:/).each { |path|
     if File.exists?("#{path}/#{cmd}") && File.executable?("#{path}/#{cmd}")
       system("#{path}/#{cmd} #{parms.join(" ")}")
       return true
     end
   }
   return false
  end

  def self.parseinput(input)
   cmd = input.split(/\s/)[0]
   parms = replacestring(input).split(/\s/)[1..-1]
   if ArshCommands.respond_to? cmd
    begin ArshCommands.send(replacestring(cmd),parms) rescue puts "#{$!}" end
   # If (full path) file is executable..
   elsif File.exists?(cmd) && File.executable?(cmd) then system("#{cmd} #{parms}")
   # If file is in PATH
   elsif ArshCommands.in_path?(cmd,parms) == false
   # Try to run input as ruby code.
       ArshCommands.ruby_eval(input)

   end
end

end

# Load Plugsins
begin
 Dir.glob("#{ARSH_INSTALL_PATH}/plugins/*.rb").each { |plugin| require plugin }
rescue
 puts "Error loading plugin: #{$!}"
end
# Main Loop

# Load rbshrc's
["/etc/rbschrc","#{ENV['HOME']}/.rbshrc"].each do |rbshrc|
  File.open(rbshrc,"r").readlines.each { |line|
    ArshCommands.parseinput(line) if line != ""
  } if File.exist?(rbshrc)
end

while true
   # Get input
   begin
   prompt = ArshCommands.rubyeval_indent == 0 ? $ps1 : "#{$ps2 * ArshCommands.rubyeval_indent} "
   input = Readline::readline(ArshCommands.replacestring(prompt)).to_s.strip
   rescue
   puts ""
   input = ""
   end
   next if input == "" # don't error on blank input
   #begin  puts input.gsub(/\#\{*\}/,'\1') rescue puts "#{$!}" end
   Readline::HISTORY.push("#{input}") # Add command to history
   ArshCommands::INTHIST.push("[#{Time.now.strftime("%a %b %d %H:%M:%S")}] #{input}")
   # If command is builtin to shell...
   ArshCommands.parseinput(input)
 end
