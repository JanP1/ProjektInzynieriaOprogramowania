extends GridContainer

func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))
	var button2 = $Button2
	button2.connect("pressed", Callable(self, "_on_button2_pressed"))
	var button9 = $Button9
	button9.connect("pressed", Callable(self, "_on_button9_pressed"))

var price_const=200
func upgradeBuilding():
	var priceOfSelected = price_const*int(Global.listUpgrading[Global.indexClicked])
	if(Global.currentMoneyPlayer-priceOfSelected > 0):
		Global._on_money_change(-priceOfSelected)
		Global.listUpgrading[Global.indexClicked]+=1
		#self.visible=false
	
	
func _on_button_pressed():
	upgradeBuilding()
	
func _on_button2_pressed():
	var buyPrice=Global.gridBuilding._get_price_of_placed_item("Kasyno")
	var priceOfSelected = buyPrice+price_const*(int(Global.listUpgrading[Global.indexClicked])-1)
	priceOfSelected=int(priceOfSelected/2)
	Global._on_money_change(priceOfSelected)
	var hexV=Global.listCollision[Global.indexClicked]
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	Global.listEverything[Global.indexClicked]=""
	Global.listUpgrading[Global.indexClicked]=1
	self.visible=false
	Global._on_const_it_unclick()
	
func _on_button9_pressed():
	self.visible=false
	Global._on_const_it_unclick()
	
