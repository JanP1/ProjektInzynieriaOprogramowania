extends Node3D

@export var swipe_speed : float = 0.02

func _input(event):
	if event is InputEventScreenDrag:
		dragging_movement(event)
		

func dragging_movement(event: InputEventScreenDrag):
	global_position = Vector3(global_position[0] + event.relative[0] * swipe_speed,
	global_position[1], global_position[2] + event.relative[1] * swipe_speed)
	

