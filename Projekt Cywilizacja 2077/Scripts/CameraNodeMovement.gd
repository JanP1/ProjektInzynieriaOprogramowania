extends Node3D

@export var swipe_speed : float = 0.02
var mouse=Vector2()

signal clicked_map_index_changed(map_ind:int)


const RAY_LENGTH = 2000
var listGrassClicked=[]
@onready var viewport_rect = get_viewport().get_visible_rect()

func _input(event):
	if event is InputEventScreenDrag:
		if event.position[0] < viewport_rect.size.x*2/3:
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
	
	if "shape" in result and viewport_rect.size.x*2/3>mousepos.x:
		var index=result["shape"]
		#var listCollision=Global.listCollision
		#var gridXY=listCollision[index]
		#var gridMapPath=Global.gridPath
		#var hexV=Global.cubeToHex(int(gridXY[0]),int(gridXY[1]))
		#print(hexV)
		#print(index)
		
		clickOnlyGrassAndOnce(index)

func _process(delta):
	pass
	var worldspace = get_world_3d().direct_space_state
	var cam = $Camera3D
	var mousepos = get_viewport().get_mouse_position()
	var start = cam.project_ray_origin(mousepos)
	var end = start + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	if "shape" in result and viewport_rect.size.x*2/3>mousepos.x:
		var index=result["shape"]
		var listCollision=Global.listCollision
		var gridXY=listCollision[index]
		var gridMapPath=Global.gridPath
		var hexV=gridXY
		var gridMapBacklight=Global.gridBacklight
		var lastBacklight=Global.lastBacklight
		#gridMapPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
		
		gridMapPath.set_cell_item(lastBacklight,0,-1)
		gridMapPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
		Global.lastBacklight=Vector3(int(hexV[0]),0, int(hexV[1]))
		
	

func clickOnlyGrassAndOnce(index):
	if index in listGrass and index not in listGrassClicked:
		clicked_map_index_changed.emit(index)
		print(index)
		#listGrassClicked.append(index)
		
		
