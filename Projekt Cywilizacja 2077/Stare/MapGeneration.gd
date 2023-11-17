@tool
extends MeshInstance3D

@export var update=false

# Called when the node enters the scene tree for the first time.
func _ready():
	gen_mesh()
	pass # Replace with function body.

func gen_mesh():
	var a_mesh=ArrayMesh.new()
	var vertices:= PackedVector3Array([
		Vector3(0,0,0),
		Vector3(1,0,0),
		Vector3(1,0,1),
		Vector3(0,0,1)
		]
	)
	var indices:=PackedInt32Array([
		0,1,2,
		0,2,3
	])
	
	var array=[]
	array.resize(Mesh.ARRAY_MAX)
	array[Mesh.ARRAY_VERTEX]=vertices
	array[Mesh.ARRAY_INDEX]=indices
	a_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,array)
	mesh=a_mesh
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if update:
		gen_mesh()
		update=false
	pass
