lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require './libs/version' unless defined? Arsh::VERSION
 
Gem::Specification.new do |s|
  s.name        = "arsh"
  s.version     = Arsh::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Paterni","Brian Faga","Eugene Howe"]
  s.email       = ["james@ruby-code.com","eugene@xtreme-computers.net"]
  s.homepage    = "http://github.com/jamez01/arsh"
  s.summary     = "Linux shell implemented in pure Ruby"
  s.description = "Provides a shell that can run pure Ruby code as well as ordinary linux commands."
  s.required_ruby_version = '>= 1.9.3'
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_dependency "rb-readline"
 
  s.files        = Dir.glob("{bin,plugins,libs}/**/*")
  s.executables  = ['arsh','arsh_configure_for_rvm']
end
