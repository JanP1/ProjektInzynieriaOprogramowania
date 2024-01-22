extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))


func _on_button_pressed():
	var money=0
	
	var len = min(Global.listEverything.size(), Global.listUpgrading.size())
	for i in range(len):
		var element = Global.listEverything[i]
		var upgrade = Global.listUpgrading[i]
	#for element in Global.listEverything and for upgrade in Global.listUpgrading:
		match element:
			"Kasyno":
				match upgrade:
					1:
						money+=10
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
