#!/usr/bin/ruby
if ! String.respond_to?("each") then
  class String
    def each(splitter)
      return self.split(splitter)
    end
  end
end

if ! Array.respond_to?("nitems") then
 class Array
  alias :nitems :count
 end
end
