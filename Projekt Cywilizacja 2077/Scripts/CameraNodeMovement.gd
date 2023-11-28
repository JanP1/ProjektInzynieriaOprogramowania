extends Node3D

@export var swipe_speed : float = 0.02
var mouse=Vector2()

const RAY_LENGTH = 2000


func _input(event):
	if event is InputEventScreenDrag:
		dragging_movement(event)
		
	if event is InputEventMouse:
		mouse = event.position
		
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_selection()
		

func dragging_movement(event: InputEventScreenDrag):
	var vecTest = Vector3(global_position[0] + event.relative[0] * swipe_speed,
	global_position[1], global_position[2] + event.relative[1] * swipe_speed)
#	print(global_position)
	
	if vecTest[0] > 37.59:
		vecTest[0] = 37.59
	if vecTest[0] < -21.18:
		vecTest[0] = -21.18
	if vecTest[2] > 29.3:
		vecTest[2] = 29.3
	if vecTest[2] < -35:
		vecTest[2] = -35
	
	global_position = vecTest




@onready var listGrass=get_node("/root/Node3D").listGrass
@onready var listWater=get_node("/root/Node3D").listWater  #("res://Scripts/hexMapGenerator.gd").listWater

func get_selection():
	var worldspace = get_world_3d().direct_space_state
	var cam = $Camera3D
	var mousepos = get_viewport().get_mouse_position()

	var start = cam.project_ray_origin(mousepos)
	var end = start + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	
	if "shape" in result:
		var index=result["shape"]
		
		clickOnlyGrassAndOnce(index)
	

func clickOnlyGrassAndOnce(index):
	if index in listGrass:
		print(index)
		listGrass.remove_at(listGrass.find(index))
