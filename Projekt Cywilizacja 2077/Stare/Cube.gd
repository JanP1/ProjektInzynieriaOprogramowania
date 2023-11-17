extends MeshInstance3D

var speed = 1  # Ustaw prędkość ruchu
var distance_between = 3.0  # Ustaw odległość między obiektami jako wartość zmiennoprzecinkową

# Called when the node enters the scene tree for the first time.
func _ready():
	print(self)
	# Utwórz nowy materiał
	# Stwórz dwie kopie obiektu
	var cubemeshinstance=MeshInstance3D.new()
	var cubemesh=load('res://cube.msh')
	cubemeshinstance.set_mesh(cubemesh)
	add_child(cubemeshinstance)
	var transform = cubemeshinstance.transform
	print(transform)
	print(transform.origin)
# Przesuń obiekt o 1 wzdłuż osi X w jego lokalnym układzie współrzędnych
	transform.origin.z += 1
	print(transform.origin)
# Przypisz zmienioną transformację z powrotem do obiektu
	cubemeshinstance.transform = transform
	cubemeshinstance.scale = Vector3(2, 2, 2)
	print(cubemeshinstance.transform)
	
	#get_parent().add_child(duplicate_2)
	var material = StandardMaterial3D.new()

	# Ustaw kolor materiału na czerwony
	material.albedo_color = Color(1, 1, 0)  # Czerwony

	# Przypisz materiał do meshu
	set_surface_override_material(0, material)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Przesunięcie obiektu w osi X w każdej klatce
	#translate(Vector3(speed * delta, 0, 0))
	pass
