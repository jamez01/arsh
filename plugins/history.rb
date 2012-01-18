module ArshCommands
  def self.history(args)
    case args.join(" ")
    when /-v/
      puts ArshCommands::INTHIST
    when /-h/
      puts <<EOF
Usage:
  -v: Verbose output; Show Timestamps.
  -h: Show this message.
EOF
    else
      ArshCommands::INTHIST[0].map { |x| puts x.gsub(/^\[.*\] /,'') }
    end
  end
end
