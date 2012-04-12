# encoding: utf-8
class String
    def console_red;          colorize(self, "\001\e[1m\e[31m\002");  end
    def console_dark_red;     colorize(self, "\001\e[31m\002");       end
    def console_green;        colorize(self, "\001\e[1m\e[32m\002");  end
    def console_dark_green;   colorize(self, "\001\e[32m\002");       end
    def console_yellow;       colorize(self, "\001\e[1m\e[33m\002");  end
    def console_dark_yellow;  colorize(self, "\001\e[33m\002");       end
    def console_blue;         colorize(self, "\001\e[1m\e[34m\002");  end
    def console_dark_blue;    colorize(self, "\001\e[34m\002");       end
    def console_purple;       colorize(self, "\001\e[1m\e[35m\002");  end

    def console_def;          colorize(self, "\001\e[1m\002");  end
    def console_bold;         colorize(self, "\001\e[1m\002");  end
    def console_blink;        colorize(self, "\001\e[5m\002");  end

    def colorize(text, color_code)  "#{color_code}#{text}\001\e[0m\002" end
end
