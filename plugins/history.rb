module ArshCommands
  def self.history(args)
    puts ArshCommands::INTHIST.find_all { |x| puts x }
  end
end