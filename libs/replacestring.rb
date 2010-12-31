module ArshCommands
  def self.replacestring(string)
    @rep_new_string = string
    begin
      repstring = /<%(.*?)%>/.match(@rep_new_string)
      loop do
        rep_original = repstring[0]
        rep_new = eval(repstring[1]).to_s
        @rep_new_string = @rep_new_string.gsub(rep_original,rep_new)
        repstring = /<%(.*?)%>/.match(@rep_new_string)
        break if repstring == nil
      end if /<%(.*?)%>/.match(@rep_new_string) != nil
    rescue
      puts $!
      @rep_new_string.gsub!(repstring[0],"[ERR]")
    end
    return @rep_new_string
  end
end
