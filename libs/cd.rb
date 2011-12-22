module ArshCommands
  # Change directory
  def self.cd(dir)
    dir = ["#{ENV['HOME']}"] if dir.nitems == 0
    if File.directory?(File.expand_path(dir.join(" ")))
      Dir.chdir(File.expand_path(dir.join(" ")))
    elsif dir =~ /~/
      dir.gsub("~","#{ENV['HOME']}")
    else
      puts "Invalid Directory #{dir.to_s}"
    end
  end
end
