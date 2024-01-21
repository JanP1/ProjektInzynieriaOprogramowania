extends GridContainer

func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	var button2 = $Button2
	button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	var button9 = $Button9
	button9.connect("pressed", Callable(self, "_on_button9_pressed"))

func changeBuilding(nameBuilding):
	var indexItem = Global.get_item_index_by_name(Global.gridPath.mesh_library, nameBuilding)
	Global.actualGridBuilding=indexItem
	
	var hexV=Global.listCollision[Global.indexClicked]
		
	Global.listBuilding[Global.indexClicked]=nameBuilding
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	self.visible=false
		
	
	
func _on_button_pressed():
	var ulepszeniePojemnosci
	self.visible=false
	
func _on_button2_pressed():
	var hexV=Global.listCollision[Global.indexClicked]
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	Global.listBuilding[Global.indexClicked]=""
	self.visible=false
	Global._on_const_it_unclick()
	
func _on_button9_pressed():
	self.visible=false
	Global._on_const_it_unclick()
	
