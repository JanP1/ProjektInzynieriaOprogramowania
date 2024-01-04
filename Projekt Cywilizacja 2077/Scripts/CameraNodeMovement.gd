extends Node3D

@export var swipe_speed : float = 0.02
var mouse=Vector2()

signal clicked_map_index_changed(map_ind:int)


const RAY_LENGTH = 2000
var listGrassClicked=[]
@onready var viewport_rect = get_viewport().get_visible_rect()
var is_mouse_button_pressed = false
func _input(event):
	if event is InputEventScreenDrag:
		if event.position[0] < viewport_rect.size.x*2/3:
			dragging_movement(event)
			Global.breakClick=1
		
	if event is InputEventMouse:
		mouse = event.position
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
			   # Przycisk lewy myszy został naciśnięty
				Global.breakClick=0
				is_mouse_button_pressed = true
			else:
			   # Przycisk lewy myszy został zwolniony
				if is_mouse_button_pressed and Global.breakClick==0:
					get_selection()
					is_mouse_button_pressed = false
		

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

func Xray():
	var worldspace = get_world_3d().direct_space_state
	var cam = $Camera3D
	var mousepos = get_viewport().get_mouse_position()
	var start = cam.project_ray_origin(mousepos)
	var end = start + cam.project_ray_normal(mousepos) * RAY_LENGTH
	return worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	

func get_selection():
	var result=Xray()
	var mousepos = get_viewport().get_mouse_position()
	
	if "shape" in result and viewport_rect.size.x*2/3>mousepos.x:
		var index=result["shape"]
		
		clickOnlyGrassAndOnce(index)

func _process(delta):
	var mousepos = get_viewport().get_mouse_position()
	var result=Xray()
	viewport_rect = get_viewport().get_visible_rect()
	if viewport_rect.size.x*2/3>mousepos.x:
		if "shape" in result:
			var index=result["shape"]
			if index in listGrass and index not in listGrassClicked:
				var listCollision=Global.listCollision
				var gridXY=listCollision[index]
				#var gridMapPath=Global.gridPath
				var hexV=gridXY
				var gridMapBacklight=Global.gridBacklight
				var lastBacklight=Global.lastBacklight
				
				gridMapBacklight.set_cell_item(lastBacklight,Global.actualGridBuilding,-1)
				gridMapBacklight.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),Global.actualGridBuilding,0)
				Global.lastBacklight=Vector3(int(hexV[0]),0, int(hexV[1]))
	else:
		var gridMapBacklight=Global.gridBacklight
		var lastBacklight=Global.lastBacklight
		gridMapBacklight.set_cell_item(lastBacklight,1,-1)

		
	

func clickOnlyGrassAndOnce(index):
	if index in listGrass and index not in listGrassClicked:
		var listCollision=Global.listCollision
		var gridXY=listCollision[index]
		var gridMapPath=Global.gridPath
		var hexV=gridXY
		gridMapPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),Global.actualGridBuilding,0)
		
		clicked_map_index_changed.emit(index)
		print(index)
		#listGrassClicked.append(index)
		
		
