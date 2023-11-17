extends MeshInstance3D

var cube_scene = preload("res://mesh_instance_3d_2.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(5):  # Przykładowa pętla, która instancjonuje pięć sześcianów wzdłuż jednej osi
		var cube = cube_scene.instance()
		cube.translation = Vector3(i * 2, 0, 0)  # Przykładowe ustawienie pozycji
		add_child(cube)  # Dodanie instancji jako dziecko do węzła
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
