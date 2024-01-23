extends Control




func _on_play_pressed():
	get_tree().change_scene_to_file("res://menu_2.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://menu_ins.tscn")



func _on_exit_pressed():
	get_tree().quit()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu_1.tscn")
	

