begin
    require_relative "../code/RGE.rb"
rescue => Errno::ENOENT
    require_relative "/code/RGE.rb"
end

app = App.new(name:"test", w:640, h:480, fps:60, zoom:1, rezisable: true)

$gb_var[:scene_change][Game.new()]

app.start()
