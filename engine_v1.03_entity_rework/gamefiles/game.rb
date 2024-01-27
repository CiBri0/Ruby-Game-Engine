require_relative "../code/RGE.rb"

app = App.new(name:"test", w:640, h:480, fps:60, zoom:1, rezisable: true)

$gb_var[:scene_change][Menu.new()]

app.start()
