extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	var button2 = $Button2
	button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	var button9 = $Button9
	button9.connect("pressed", Callable(self, "_on_button9_pressed"))

	
func _on_button_pressed():
	Global.robotMove=1
	Global.start=Global.indexClicked
	
	
func _on_button2_pressed():
	var dodajZloto
	
	var hexV=Global.listCollision[Global.indexClicked]
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	Global.listEverything[Global.indexClicked]=""
	self.visible=false
	Global._on_const_it_unclick()
	
	Global.robotMove=0

func _on_button9_pressed():
	self.visible=false
	Global.robotMove=0
