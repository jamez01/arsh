# Evaluate ruby code typed into command line.  Allow multiple lines of code before evaluting blcoks.
module ArshCommands
    @rubyeval_proc = Proc.new {}
    @rubyeval_indent = 0
    @rubyeval_history = Array.new
    def self.rubyeval_indent
      return @rubyeval_indent
    end
    def self.ruby_eval(input)
    # keywords that start a block
    start_strings = ["class,","module","def","do","{","("]
    # Keywords that end a block
    end_strings = ["end","}",")"]
    # Add last line typed to
    @rubyeval_history << input
    start_strings.each {|string| @rubyeval_indent += 1 if input.include? string}
    end_strings.each {|string| @rubyeval_indent -=1 if input.include? string}
    #input.strip.each(" ") {|string| @rubyeval_indent += 1 if start_strings.include? string }
    #input.strip.each(" ") {|string| @rubyeval_indent -= 1 if end_strings.include? string }
    if @rubyeval_indent <= 0
      @rubyeval_indent = 0
      begin
        eval(@rubyeval_history.join("\n"),@rubyeval_proc.binding)
        @rubyeval_history = Array.new
      rescue ScriptError, StandardError
        @rubyeval_history = Array.new
        puts "#{$!}"
      end
    end
  end
end
