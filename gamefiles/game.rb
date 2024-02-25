require_relative "../code/RGE.rb"

app = App.new(name:"test", w:1280, h:720, fps:60, rezisable: true)

$gb_var[:scene_change][Game2.new()]

app.start()
