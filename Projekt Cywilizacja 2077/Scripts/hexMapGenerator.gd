extends Node3D


func cubeToHex(x,y):
	var x2=x
	x*=-2
	y*=2
	if x2%2==0:
		y+=1
	return Vector2(x,y)


const dir=[Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

const hexDir=["N","NE","SE","S","SW","NW"]

var grid_size=40
var grid_steps=50
var list1=[]
var hexV=cubeToHex(0,0)
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
			#print(current_pos)
			#list1.append(current_pos)
			list1.append(1)
		
	for i in range(20):
		var waterX=randi_range(0,grid_size)
		var waterY=randi_range(0,grid_size)	
		for waterX2 in range(grid_size+1):
			for waterY2 in range(grid_size+1):
				var radius=randi_range(4,7)
				if (waterX2-waterX)**2+(waterY2-waterY)**2<radius:
					hexV=cubeToHex(waterX2,waterY2)
					$GridMap2.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
					list1.append(hexV)
		
		#$GridMap.set_cell_item(Vector3i((current_pos.x),0, (current_pos.y)),0,0)
	var dictionary={
		"key1":"valueXY"
	}
	dictionary[str(0)]=[-5,5]
	#$GridMap2.set_cell_item(Vector3i(int(dictionary[str(0)][0]),0, int(dictionary[str(0)][1])),0,0)
	
	hexV=cubeToHex(3,2)
	#$GridMap2.set_cell_item(Vector3i(int(test[0]),0, int(test[1])),0,0)
	for i in range(grid_size+1):
		for j in range(grid_size+1):
			hexV=cubeToHex(i,j)
			if hexV not in list1:
				$GridMap.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
				
			$GridMapCollision.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
#	$GridMapCollision.set_navigation_map(RID(10))
	var cos2=$GridMapCollision.get_navigation_map()
	var cos3=$GridMapCollision.get_cell_item(Vector3i(0,0,3))
	print(cos3)
	
#	print(cos2)
#	var grid_map=$GridMapCollision
#	for x in range(grid_map.get_used_cells().size()):
#		var cell_pos = grid_map.get_used_cells()[x]
#		var rid = grid_map.get_cell_item_id(cell_pos.x, cell_pos.y, cell_pos.z)
#		print("RID at position", cell_pos, "is", rid)
	
#	grid_size*=2	
#	for y in range(grid_size+1):
#		var y2=y
#		for x in range(0,-grid_size-1,-1):
#			if x%2!=0 and y%2!=0:
#				y2=y
#				if (x+3)%4==0:
#					print(x)
#					y2+=1
#				var c=Vector2(x,y2)
#				if (c not in list1):
#					print(c)
					#$GridMap.set_cell_item(Vector3i(int(x),0, int(y2)),0,0)
				
				
				#$GridMap2.set_cell_item(Vector3i(int(i),0, int(j)),0,0)
#	print(list1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
