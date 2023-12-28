def path(str, label = "")
    return Dir.pwd + "/" + label.to_s + str
end

def load(str)
    puts("Loading " + str)
    require_relative str
end

def group(str)
    Dir.foreach("code/" + str) do |filename|
        next if filename == '.' or filename == '..'
        load str + "/" + filename
    end
end

def all(str)
    puts("--Loading folder " + str + "--")
    Dir.foreach(Dir.pwd + "/../code/" + str) do |filename|
        next if filename == "lib"
        next if filename == '.' or filename == '..'
        next all(filename + "/") if not filename.end_with?(".rb")
        load Dir.pwd + "/../code/" + str + filename
    end
    puts ""
end

def all_self(str)
    puts("--Loading folder " + str + "/ --")
    Dir.foreach(Dir.pwd + "/" + str) do |filename|
        next if filename == "lib"
        next if filename == '.' or filename == '..'
        next all(filename + "/") if not filename.end_with?(".rb")
        load Dir.pwd + "/" + str  + "/" +  filename
    end
    puts ""
end

require 'sdl2'

all("")

all_self("entities")
all_self("scenes")

include Graphics

