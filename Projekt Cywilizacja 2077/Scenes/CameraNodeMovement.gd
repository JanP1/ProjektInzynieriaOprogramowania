extends Node3D

@export var swipe_speed : float = 0.02
var mouse=Vector2()

const RAY_LENGTH = 1000


func _input(event):
	if event is InputEventScreenDrag:
		dragging_movement(event)
		
#	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
#		var camera3d = $Camera3D
#		var from = camera3d.project_ray_origin(event.position)
#		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
			
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




#func _physics_process(delta):
#	var space_state = get_world_3d().direct_space_state
#	var cam = $Camera3D
#	var mousepos = get_viewport().get_mouse_position()
#
#	var origin = cam.project_ray_origin(mousepos)
#	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
#	var query = PhysicsRayQueryParameters3D.create(origin, end)
#	query.collide_with_areas = true
#
#	var result = space_state.intersect_ray(query)
##	if result:
#	print(result)

func get_selection():
	var worldspace = get_world_3d().direct_space_state
#	var start = project_ray_origin(mouse)
#	var end = project_position(mouse, 1000)
	var cam = $Camera3D
	var mousepos = get_viewport().get_mouse_position()

	var start = cam.project_ray_origin(mousepos)
	var end = start + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	print(result)
#	result.costam = true
#	print(str(result["rid"]).get_slice("(", ")"))
	if "rid" in result:
		var rid_string = str(result["rid"])  # Konwersja RID do stringa
		var rid_parts = rid_string.split("(")  # Podział stringa względem znaku '('
		
		var rid_number = rid_parts[1].replace(")", "")  # Usunięcie ')' ze stringa
#		print(result["rid"].get_id())
#		print(int(rid_number)-3474628542521) 
	
	var map=get_node("/root/Node3D/GridMapCollision")#$GridMapCollision
#	var map=load("res://Scenes/map.tscn").instance()
	if map:
		print(map)
		var point =result["position"]#map.world_to_map(result["position"])
		var tile=map.get_cell_item(Vector3i(point.x,point.y,point.z))
		print(tile)


#func _process(delta):
#	if Input.is_action_just_pressed("mouse_left"):
#		var mouse_pos = get_viewport().get_mouse_position()
#		var viewport_size = get_viewport().get_visible_rect().size
#
#		# Pozycja myszy w odniesieniu do obszaru widoku
#		var normalized_mouse_pos = Vector2(
#			mouse_pos.x / viewport_size.x * 2 - 1,
#			mouse_pos.y / viewport_size.y * 2 - 1
#		)
#
#		# Uzyskaj pozycję kamery w świecie gry
#		var from = global_transform.origin
#
#		# Uzyskaj kierunek raycastu od kamery w kierunku pozycji myszy
#		var to = from + global_transform.basis.z * 1000  # Mnożnik (1000) to długość raycastu
#		var worldspace = get_world_3d().direct_space_state
##		var space_state = get_world_3d().direct_space_state
#		var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(from, to))
##		var Intersection = SpaceState.intersect_ray(query)
#		#var result = space_state.intersect_ray(P(from, to))
#
#		# Sprawdź, czy raycast trafił w coś
#		if result.size() > 0:
#			var collision_point = result.position
#			var collision_normal = result.normal
#			# Operacje na punkcie kolizji i normalnej
#			print("Collision at: ", collision_point)
#			print("Collision normal: ", collision_normal)

#onready var camera=$Camera3D
#func get_selection():
#	var worldspace=get_world_3d().direct_space_state
#	var start = project_ray_origin(mouse)
#	var end = project_position(mouse, 1000)
#	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	
