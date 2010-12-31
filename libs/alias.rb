module ArshCommands
  def self.alias(args)
    args = args.join(" ")
    alias_cmd, alias_body = args.split(/=/,2)
    alias_body_cmd, alias_body_params = alias_body.split(/ /,2)
    alias_cmd.strip!
    alias_body_cmd.strip!
    if alias_body_params != nil then
      alias_body_params.strip
    else
      alias_body_params = ""
    end
    new_alias =<<-EOS
 	    def self.#{alias_cmd}(args=[])
	    	args = ["#{alias_body_params} "] + args
	    	system("#{alias_body_cmd} \#{args.join(' ')}")
	    end
	  EOS
    ArshCommands.module_eval(new_alias)
    end
  end