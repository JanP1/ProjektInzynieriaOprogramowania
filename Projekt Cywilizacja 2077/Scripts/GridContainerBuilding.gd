extends GridContainer

#Signals------------
signal money_changed(newMoneyValue:int)

#-------------------

func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	var button2 = $Button2
	button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	var button3 = $Button3
	button3.connect("pressed", Callable(self, "_on_button3_pressed"))
	var button4 = $Button4
	button4.connect("pressed", Callable(self, "_on_button4_pressed"))
	var button9 = $Button9
	button9.connect("pressed", Callable(self, "_on_button9_pressed"))

func changeBuilding(nameBuilding):
	var indexItem = Global.get_item_index_by_name(Global.gridPath.mesh_library, nameBuilding)
	Global.actualGridBuilding=indexItem
	#Global.actualGridBuildingName=nameBuilding
	
	var hexV=Global.listCollision[Global.indexClicked]
	var priceOfSelected = _get_price_of_placed_item(nameBuilding)
	if(Global.currentMoneyPlayer-priceOfSelected > 0):
		money_changed.emit(Global.currentMoneyPlayer-priceOfSelected)
		Global.currentMoneyPlayer -= priceOfSelected
		
		Global.listBuilding[Global.indexClicked]=nameBuilding
		Global.listEverything[Global.indexClicked]=nameBuilding
		var xClick=Global.indexToVector(Global.indexClicked)[0]
		var yClick=Global.indexToVector(Global.indexClicked)[1]
		Global.mapMovement[xClick][yClick]=0
		Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),Global.actualGridBuilding,0)
		self.visible=false
		
#func deleteElement(name):
		
	
func _on_button_pressed():
	#Kasyno
	changeBuilding("Kasyno")
	
	
	
func _on_button2_pressed():
	#Bank
	changeBuilding("Bank")
	
func _on_button3_pressed():
	#Koszary
	changeBuilding("Koszary")
	
func _on_button4_pressed():
	#Laboratorium
	changeBuilding("Laboratorium")
	
func _on_button9_pressed():
	self.visible=false



func _get_price_of_placed_item(itemName):
	var itemPrice = 0
	
	#Place to put any item name, that is available on the building menu
	match itemName:
		"Kostka":
			itemPrice = 450
		"Okrąg":
			itemPrice = 5
	return itemPrice
