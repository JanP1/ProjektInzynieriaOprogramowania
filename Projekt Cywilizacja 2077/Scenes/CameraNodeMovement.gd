extends Node3D

@export var swipe_speed : float = 0.02
var mouse=Vector2()

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



#
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
#
#		var space_state = get_world_3d().direct_space_state
#		var query = PhysicsRayQueryParameters3D.create(RayOrigin, RayEnd);
#		var Intersection = SpaceState.intersect_ray(query)
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
	
