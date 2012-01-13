module ArshCommands
  def self.rvm(command)
    $stdout.sync = true
    $stderr.sync = true
    time = Time.now.to_i
    command = command.is_a?(Array) ? command.join(' ') : command
    case command
    when /^use /
      @output = %x{bash -c "source #{ENV['rvm_path']}/scripts/rvm; rvm #{command}; env | grep -i rvm"}
      @output.split("\n").select { |l| l[/=/] }.each do |n|
        var, value = n.split(/=/,2)
        ENV[var] = value
      end
      puts "\e[32mUsing #{ENV['GEM_HOME']}\e[0m"
    else
      exec %Q{bash -c "source #{ENV['rvm_path']}/scripts/rvm; rvm #{command}"}
     end
  end
end
