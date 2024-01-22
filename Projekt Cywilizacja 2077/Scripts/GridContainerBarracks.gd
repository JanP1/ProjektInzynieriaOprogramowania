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

	
func createRobot(nameRobot):
	var indexItem = Global.get_item_index_by_name(Global.gridPath.mesh_library, nameRobot)
	Global.actualGridBuilding=indexItem
	
	var hexV=Global.listCollision[Global.barrackNeighbor]
	var priceOfSelected = _get_price_of_placed_item(nameRobot)
	if(Global.currentMoneyPlayer-priceOfSelected > 0):
		
		Global._on_money_change(-priceOfSelected)
		
		#Global.listBuilding[Global.indexClicked]=nameBuilding
		Global.listEverything[Global.barrackNeighbor]=nameRobot
		Global.listHP[Global.barrackNeighbor]=giveHP(nameRobot) ######################################################################TUTAJ
		Global.listStrength[Global.barrackNeighbor]=giveStrength(nameRobot)
		Global.listRange[Global.barrackNeighbor]=giveStrength(nameRobot)
		var xClick=Global.indexToVector(Global.barrackNeighbor)[0]
		var yClick=Global.indexToVector(Global.barrackNeighbor)[1]
		Global.mapMovement[xClick][yClick]=0
		Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),Global.actualGridBuilding,0)
		self.visible=false
		
		
func _on_button_pressed():
	createRobot("RobotDefensywny")
	
func _on_button2_pressed():
	createRobot("RobotOfensywny")
	
	
func _on_button3_pressed():
	var buyPrice=Global.gridBuilding._get_price_of_placed_item("Koszary")
	var priceOfSelected = buyPrice
	priceOfSelected=int(priceOfSelected/2)
	Global._on_money_change(priceOfSelected)
	var hexV=Global.listCollision[Global.indexClicked]
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	Global.listEverything[Global.indexClicked]=""
	self.visible=false
	Global._on_const_it_unclick()

func giveRange(itemName):
	var range = 0
	
	#Place to put any item name, that is available on the building menu
	match itemName:
		"RobotDefensywny":
			range = 100*Global.RobotRangeUpgrade
		"RobotOfensywny":
			range = 5*Global.RobotRangeUpgrade
	return range

func giveStrength(itemName): ######################################################################TUTAJ
	
	var strength = 0
	
	#Place to put any item name, that is available on the building menu
	match itemName:
		"RobotDefensywny":
			strength = 100*Global.RobotDefensywnyUpgrade
		"RobotOfensywny":
			strength = 5*Global.RobotOfensywnyUpgrade
	return strength
	

func giveHP(itemName): ######################################################################TUTAJ
	
	var hp = 0
	
	#Place to put any item name, that is available on the building menu
	match itemName:
		"RobotDefensywny":
			hp = 100*Global.RobotDefensywnyUpgrade
		"RobotOfensywny":
			hp = 5*Global.RobotOfensywnyUpgrade
	return hp
	

func _get_price_of_placed_item(itemName):
	var itemPrice = 0
	
	#Place to put any item name, that is available on the building menu
	match itemName:
		"RobotDefensywny":
			itemPrice = 450
		"RobotOfensywny":
			itemPrice = 5
	return itemPrice
