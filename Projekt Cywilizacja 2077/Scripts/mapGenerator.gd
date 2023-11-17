extends Node3D

const dir=[Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

var grid_size=14
var grid_steps=50
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var current_pos=Vector2(0,0)
	
	var current_dir=Vector2.RIGHT
	var last_dir=current_dir*-1
	
	for i in range(0, grid_steps):
		var temp_dir=dir.duplicate()
		temp_dir.shuffle()
		var d=temp_dir.pop_front()
		
		while(abs(current_pos.x+d.x)>grid_size or abs(current_pos.y+d.y)>grid_size or d==last_dir*-1):
			temp_dir.shuffle()
			d=temp_dir.pop_front()
		
		current_pos+=d
		last_dir=d
		
		$GridMap.set_cell_item(Vector3i(int(current_pos.x),0, int(current_pos.y)),0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
