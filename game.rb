require_relative "code/RGE.rb"
load "scenes/menu.rb"

app = App.new(name:"test", w:960, h:720, fps:60)

$gb_var[:scene_change][Menu.new()]

app.start()
