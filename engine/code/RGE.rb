def path(str, label = "")
    return Dir.pwd + "/" + label.to_s + str
end

def load(str)
    puts("Launching " + str)
    require_relative str
end

def group(str)
    Dir.foreach("code/" + str) do |filename|
        next if filename == '.' or filename == '..'
        load str + "/" + filename
    end
end

require 'sdl2'
load "scene.rb"
load "entity.rb"
load "image.rb"
load "save.rb"
load "sound.rb"
load "app.rb"
load "graphics.rb"

group("ecs")

group("entities")

group("scenes")

include Graphics

