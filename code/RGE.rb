ENGINE = "Engine V1.03_ENTITY_REWORK"

LOG = ""
ERROR = "ERROR | "
WARN = "WARN | "

def error(str)
    puts "\e[31m" + log_text(str, ERROR) + "\e[0m"
    exit()
end

def warn(str)
    puts "\e[33m" + log_text(str, WARN) + "\e[0m"
end

def log(str = "")
    puts(log_text(str, LOG))
end

def important(str)
    puts "\e[34m" + log_text(str, LOG) + "\e[0m"
end

def very_important(str)
    puts "\e[32m" + log_text(str, LOG) + "\e[0m"
    puts "\n"
end

def log_text(str, type)
    return ENGINE + " | " + type + Time.now.strftime("%d/%m/%Y %H:%M:%S")  + " : " + str.to_s
end

def space(x = 1)
    puts("\n" * x)

end



def path(str, label = "")
    return Dir.pwd + "/" + label.to_s + str
end

def load(str)
    log("Loading " + str)
    require_relative str
end

def group(str)
    Dir.foreach("code/" + str) do |filename|
        next if filename == '.' or filename == '..'
        load str + "/" + filename
    end
end

def lib(str)
    log("Loading " + str)
    require str
end

def all(str)
    puts ""
    important("Loading folder " + str + "..")
    Dir.foreach(Dir.pwd + str) do |filename|
        next if filename == '.' or filename == '..' or filename == "RGE.rb" or filename == "lib"
        next if filename.start_with?("-")
        next all(str + filename + "/") if !filename.end_with?(".rb")
        load Dir.pwd + str + filename
    end
    puts ""
end

puts('
    ______   _______   _______
   |   __ \ |     __/ |    ___/
   |      / |    |  \ |    __|
   |___|__\ |_______| |_______\

   ')

# puts('
#      ______   _______   _______
#     |   __ \ |     __| |    ___|
#     |      < |    |  | |    ___|
#     |___|__| |_______| |_______|

#     ')


very_important("Loading Lib")

space(1)

lib("sdl2")
lib("matrix")
lib("win32ole")


space(2)


very_important("Loading RGE")

all("/../code/")


very_important("Loading GAMEFILES")

all("/code/")
