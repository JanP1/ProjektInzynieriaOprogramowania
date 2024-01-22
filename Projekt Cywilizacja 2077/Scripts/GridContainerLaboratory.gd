extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	var button2 = $Button2
	button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	var button3 = $Button3
	button3.connect("pressed", Callable(self, "_on_button3_pressed"))
	var button8 = $Button8
	button8.connect("pressed", Callable(self, "_on_button8_pressed"))
	var button9 = $Button9
	button9.connect("pressed", Callable(self, "_on_button9_pressed"))
	
var price_const=200	
func robotUpgrade(robotUpgrade):
	var priceOfSelected = price_const*robotUpgrade
	if(Global.currentMoneyPlayer-priceOfSelected > 0):
		
		Global._on_money_change(-priceOfSelected)
		#Global.listUpgrading[Global.indexClicked]+=1
		robotUpgrade+=1
		self.visible=false
		
		
func _on_button_pressed():
	robotUpgrade(Global.RobotDefensywnyUpgrade)
	#Ulepsz Robot Defensywny
	#Global.listHP[Global.indexClicked]
	#Global.listStrength[Global.indexClicked]
	#changeBuilding("RobotDefensywny")
	
func _on_button2_pressed():
	robotUpgrade(Global.RobotOfensywnyUpgrade)
	#Ulepsz Robot Ofensywny
	#changeBuilding("RobotOfensywny")
func _on_button3_pressed():
	robotUpgrade(Global.RobotRangeUpgrade)
	#Global.listHP[Global.indexClicked]
	#Ulepsz Robot Zasieg
	#changeBuilding("Kostka")
	
	
func _on_button8_pressed():
	var buyPrice=Global.gridBuilding._get_price_of_placed_item("Bank")
	var priceOfSelected = buyPrice#+price_const*(int(Global.listUpgrading[Global.indexClicked])-1)
	priceOfSelected=int(priceOfSelected/2)
	Global._on_money_change(priceOfSelected)
	var hexV=Global.listCollision[Global.indexClicked]
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	Global.listEverything[Global.indexClicked]=""
	self.visible=false
	Global._on_const_it_unclick()
	var ok=0
	for element in Global.listEverything:
		if element in ["Laboratorium","RobotOfensywny"]:
			ok=1
	if ok==0:
		Global.RobotDefensywnyUpgrade=0
		Global.RobotOfensywnyUpgrade=0
		Global.RobotRangeUpgrade=0


func _get_price_of_placed_item(itemName):
	var itemPrice = 0
	
	#Place to put any item name, that is available on the building menu
	match itemName:
		"UlepszRobotDefensywny":
			itemPrice = 450
		"UlepszRobotOfensywny":
			itemPrice = 5
		"UlepszRobotZasieg":
			itemPrice = 5
	return itemPrice
