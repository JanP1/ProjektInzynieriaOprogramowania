extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	var button2 = $Button2
	button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	var button3 = $Button3
	button3.connect("pressed", Callable(self, "_on_button3_pressed"))
	var button9 = $Button9
	button9.connect("pressed", Callable(self, "_on_button9_pressed"))
	
func changeBuilding(nameBuilding):
	var indexItem = Global.get_item_index_by_name(Global.gridPath.mesh_library, nameBuilding)
	Global.actualGridBuilding=indexItem
	
	var hexV=Global.listCollision[Global.indexClicked]
	var priceOfSelected = _get_price_of_placed_item(nameBuilding)
	if(Global.currentMoneyPlayer-priceOfSelected > 0):
		Global._on_money_changed(Global.currentMoneyPlayer-priceOfSelected)
		Global.currentMoneyPlayer -= priceOfSelected
		
		Global.listBuilding[Global.indexClicked]=nameBuilding
		Global.listEverything[Global.indexClicked]=nameBuilding
		var xClick=Global.indexToVector(Global.indexClicked)[0]
		var yClick=Global.indexToVector(Global.indexClicked)[1]
		Global.mapMovement[xClick][yClick]=0
		Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),Global.actualGridBuilding,0)
		self.visible=false
		
		
func _on_button_pressed():
	#Robot Defensywny
	changeBuilding("RobotDefensywny")
	
func _on_button2_pressed():
	#Robot Ofensywny
	changeBuilding("RobotOfensywny")
	
	
func _on_button3_pressed():
	var hexV=Global.listCollision[Global.indexClicked]
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	Global.listEverything[Global.indexClicked]=""
	self.visible=false
	Global._on_const_it_unclick()


func _get_price_of_placed_item(itemName):
	var itemPrice = 0
	
	#Place to put any item name, that is available on the building menu
	match itemName:
		"RobotDefensywny":
			itemPrice = 450
		"RobotOfensywny":
			itemPrice = 5
	return itemPrice
