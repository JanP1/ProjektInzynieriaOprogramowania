extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var play = $"Postac 1"
	play.connect("pressed", Callable(self, "_on_play_pressed"))
	var play2 = $"Postac 2"
	play2.connect("pressed", Callable(self, "_on_play2_pressed"))
	var play3 = $"Postac 3"
	play3.connect("pressed", Callable(self, "_on_play3_pressed"))
	var play4 = $"Postac 4"
	play4.connect("pressed", Callable(self, "_on_play4_pressed"))
	pass # Replace with function body.
	
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/map.tscn")
	
func _on_play2_pressed():
	get_tree().change_scene_to_file("res://Scenes/map.tscn")
	
func _on_play3_pressed():
	get_tree().change_scene_to_file("res://Scenes/map.tscn")
	
func _on_play4_pressed():
	get_tree().change_scene_to_file("res://Scenes/map.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
