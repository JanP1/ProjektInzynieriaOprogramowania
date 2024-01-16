extends GridContainer

func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	var button2 = $Button2
	button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	var button9 = $Button9
	button9.connect("pressed", Callable(self, "_on_button9_pressed"))

func changeBuilding(nameBuilding):
	var gridMap=Global.gridBacklight
	var indexItem = Global.get_item_index_by_name(gridMap.mesh_library, nameBuilding)
	Global.actualGridBuilding=indexItem
	Global.actualGridBuildingName=nameBuilding
	
	
	
func _on_button_pressed():
	pass
	
	
func _on_button2_pressed():
	changeBuilding("Okrąg")
#signal constructed_item_unclicked()
func _on_button9_pressed():
	var hexV=Global.listCollision[Global.indexClicked]
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	Global.listBuilding[Global.indexClicked]=""
	self.visible=false
	Global._on_const_it_unclick()
	
	#constructed_item_unclicked.emit()
	#var gridContainer=Global.gridMenu
	#gridContainer.visible=true
	#self.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
   #print(stop)
	pass
