extends Node3D

const dir=[Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

const hexDir=["N","NE","SE","S","SW","NW"]

var grid_size=5
var grid_steps=50
var list1=[]
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
		
		while(abs(current_pos.x+d.x)>grid_size or abs(current_pos.y+d.y)>grid_size or d==last_dir*-1):# or ((current_pos+d) in list1)):
			temp_dir.shuffle()
			d=temp_dir.pop_front()
		
		current_pos+=d
		last_dir=d
		if current_pos not in list1:
			print(current_pos)
			list1.append(current_pos)
		
		
		
		$GridMap.set_cell_item(Vector3i((current_pos.x),0, (current_pos.y)),0,0)
	
	grid_size*=2	
	for i in range(-grid_size,grid_size+1):
		for j in range(-grid_size,grid_size+1):
			var c=Vector2(i,j)
			if (c not in list1):
				print(c)
				$GridMap2.set_cell_item(Vector3i(int(i),0, int(j)),0,0)
	print(list1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
