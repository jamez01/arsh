module ArshCommands
  def self.rvm(command)
    command = command.is_a?(Array) ? command.join(' ') : command
    case command
    when /^use /
      @output = %x{bash -c "source #{ENV['HOME']}/.rvm/scripts/rvm; rvm #{command}; env | grep -i rvm"}
      @output.split("\n").select { |l| l[/=/] }.each do |n|
        var, value = n.split(/=/,2)
        ENV[var] = value
      end
      puts "\e[32mUsing #{ENV['GEM_HOME']}\e[0m"
    else
      puts "\e[01;32mUsing Ctrl-C on this operation will push the operation to the background.\nThe operation will not stop\e[0m"
      pid = ""
      Process.fork do
        pid = Process.pid
        print "\n"
        exec %Q{bash -c "source #{ENV['HOME']}/.rvm/scripts/rvm; rvm #{command}"}
      end
      Process.waitpid(pid.to_i)
    end
  end
end
