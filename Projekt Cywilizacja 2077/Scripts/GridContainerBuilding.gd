extends GridContainer

func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	var button9 = $Button9
	button9.connect("pressed", Callable(self, "_on_button9_pressed"))

func _on_button_pressed():
	print("Hello world!")
	var gridMapPath=Global.gridPath
	var mousepos = get_viewport().get_mouse_position()
	var hexV=Global.cubeToHex(int(mousepos.x),int(mousepos.y))
	hexV=Global.cubeToHex(int(1),int(1))
	gridMapPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	
func _on_button9_pressed():
	print("ok")
	var gridContainer=Global.gridMenu
	gridContainer.visible=true
	self.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
   #print(stop)
	pass
