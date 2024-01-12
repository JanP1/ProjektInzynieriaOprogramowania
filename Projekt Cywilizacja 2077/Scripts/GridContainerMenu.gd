extends GridContainer

func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	var gridContainer=Global.gridBuilding
	gridContainer.visible=true
	self.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
