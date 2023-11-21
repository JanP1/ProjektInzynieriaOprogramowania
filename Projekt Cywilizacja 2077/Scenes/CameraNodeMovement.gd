extends Node3D

@export var swipe_speed : float = 0.02

func _input(event):
	if event is InputEventScreenDrag:
		dragging_movement(event)
		

func dragging_movement(event: InputEventScreenDrag):
	var vecTest = Vector3(global_position[0] + event.relative[0] * swipe_speed,
	global_position[1], global_position[2] + event.relative[1] * swipe_speed)
	print(global_position)
	
	if vecTest[0] > 37.59:
		vecTest[0] = 37.59
	if vecTest[0] < -21.18:
		vecTest[0] = -21.18
	if vecTest[2] > 29.3:
		vecTest[2] = 29.3
	if vecTest[2] < -35:
		vecTest[2] = -35
	
	global_position = vecTest
