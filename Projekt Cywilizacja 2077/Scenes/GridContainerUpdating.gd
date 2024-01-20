extends GridContainer

func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	var button2 = $Button2
	button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	var button9 = $Button9
	button9.connect("pressed", Callable(self, "_on_button9_pressed"))

func changeBuilding(nameBuilding):
	#var gridMap=Global.gridBacklight
	#var indexItem = Global.get_item_index_by_name(gridMap.mesh_library, nameBuilding)
	#Global.actualGridBuilding=indexItem
	#Global.actualGridBuildingName=nameBuilding
	var indexItem = Global.get_item_index_by_name(Global.gridPath.mesh_library, nameBuilding)
	Global.actualGridBuilding=indexItem
	#Global.actualGridBuildingName=nameBuilding
	
	var hexV=Global.listCollision[Global.indexClicked]
		
	Global.listBuilding[Global.indexClicked]=nameBuilding
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	#Global.gridUpdating.visible=false
		
	
	
func _on_button_pressed():
	var ulepszenieZarabiania
	#Global.robotMove=1
	#Global.start=Global.indexClicked
	
	
func _on_button2_pressed():
	var hexV=Global.listCollision[Global.indexClicked]
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	Global.listBuilding[Global.indexClicked]=""
	self.visible=false
	Global._on_const_it_unclick()
	#Global.robotMove=0
	
	#changeBuilding("Okrąg")
#signal constructed_item_unclicked()
func _on_button9_pressed():
	#var hexV=Global.listCollision[Global.indexClicked]
	#Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	#Global.listBuilding[Global.indexClicked]=""
	#Global.robotMove=0
	self.visible=false
	Global._on_const_it_unclick()
	
	#constructed_item_unclicked.emit()
	#var gridContainer=Global.gridMenu
	#gridContainer.visible=true
	#self.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.

