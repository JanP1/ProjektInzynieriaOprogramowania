extends Node3D

#const dir=[Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

#const hexDir=["N","NE","SE","S","SW","NW"]

var grid_size=40
#var grid_steps=50
var list1=[]
var listWater=[]
var listGrass=[]
var hexV
var hexI

func cubeToHex(x,y):
	var x2=x
	x*=-2
	y*=2
	if x2%2==0:
		y+=1
	return Vector2(x,y)
	
func indexHex(x,y):
	return y+x*grid_size


# Called when the node enters the scene tree for the first time.
func _ready():
	var mapMovement=[]
	for i in range(grid_size):
		var mapMovementTmp=[]
		for j in range(grid_size):
			Global.listEverything.append("")
			Global.listGround.append("")
			Global.listRobotMove.append([])
			Global.listHP.append(0)
			Global.listStrength.append(0)
			Global.listRange.append(0)
			Global.listUpgrading.append(1)
			mapMovementTmp.append(1)
		mapMovement.append(mapMovementTmp)
		
		
	
	var losX=randi_range(7,grid_size-7)
	var losY=randi_range(7,grid_size-7)
	hexV=cubeToHex(losX,losY)
	print(losX,losY)
	hexI=indexHex(losX,losY)
	#listGrass.append(hexI)
	Global.listGround[hexI]="desert"
	list1.append(hexV)
	$GridMapDesert.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	
	var zez=Global.get_item_index_by_name(Global.gridPath.mesh_library, "StolicaWroga")
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),zez,0)
	Global.listEverything[hexI]="StolicaWroga"
	Global.listHP[hexI]=1000
	#print(mapMovement)
#	randomize()
#	var current_pos=Vector2(0,0)
	
#	var current_dir=Vector2.RIGHT
#	var last_dir=current_dir*-1
#
#	for i in range(0, grid_steps):
#		var temp_dir=dir.duplicate()
#		temp_dir.shuffle()
#		var d=temp_dir.pop_front()
#
#		while(abs(current_pos.x+d.x)>grid_size or abs(current_pos.y+d.y)>grid_size or d==last_dir*-1):# or ((current_pos+d) in list1)):
#			temp_dir.shuffle()
#			d=temp_dir.pop_front()
#
#		current_pos+=d
#		last_dir=d
#		if current_pos not in list1:
#			#print(current_pos)
#			#list1.append(current_pos)
#			list1.append(1)
	hexV=cubeToHex(3,2)
	#for i in range(grid_size):
	var GrassX=randi_range(7,grid_size-7)
	var GrassY=randi_range(7,grid_size-7)
	hexV=cubeToHex(GrassX,GrassY)
	#KAMERA POSITION
					#Global.cameraNodeCamera3D.position=Vector3i(-GrassX-10,25,GrassY)
	#Global.cameraNodeCamera3D.position=Vector3i(hexV[0],25,hexV[1])
	print(GrassX,GrassY)
	
	hexI=indexHex(GrassX,GrassY)
	listGrass.append(hexI)
	list1.append(hexV)
	$GridMapGrass.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	
	var z=Global.get_item_index_by_name(Global.gridPath.mesh_library, "RobotWrogi")
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),z,0)
	Global.listEverything[hexI]="RobotWrogi"
	Global.listHP[hexI]=100
	
	hexI=indexHex(GrassX-3,GrassY-3)
	hexV=cubeToHex(GrassX-3,GrassY-3)
	z=Global.get_item_index_by_name(Global.gridPath.mesh_library, "BudynekWrogi")
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),z,0)
	Global.listEverything[hexI]="BudynekWrogi"
	Global.listHP[hexI]=100
	
	var radius=200
	for grassX2 in range(grid_size):
		for grassY2 in range(grid_size):	
			hexV=cubeToHex(grassX2,grassY2)
			var hexV2=cubeToHex(GrassX,GrassY)
			if (int(hexV[0])-int(hexV2[0]))**2+(int(hexV[1])-int(hexV2[1]))**2<radius:
				if hexV not in list1:
					$GridMapGrass.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
					hexI=indexHex(grassX2,grassY2)
					listGrass.append(hexI)
					list1.append(hexV)
			#if (int(hexV[0])-int(hexV2[0]))**2+(int(hexV[1])-int(hexV2[1]))**2<radius+1:
				#Global.listGround[hexI]="grass"
			
	
	
	
		
	for i in range(20):
		var waterX=randi_range(0,grid_size)
		var waterY=randi_range(0,grid_size)
		for waterX2 in range(grid_size):
			for waterY2 in range(grid_size):
				radius=randi_range(4,7)
				if (waterX2-waterX)**2+(waterY2-waterY)**2<radius:
					hexV=cubeToHex(waterX2,waterY2)
					if hexV not in list1:
						$GridMapWater.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
						list1.append(hexV)
						hexI=indexHex(waterX2,waterY2)
						listWater.append(hexI)
						mapMovement[waterX2][waterY2]=0
						Global.listGround[hexI]="water"
						Global.listEverything[hexI]="water"
	#print(mapMovement)
	Global.mapMovement=mapMovement
	
	
	

	hexV=cubeToHex(3,2)
	for i in range(grid_size):
		for j in range(grid_size):
			hexV=cubeToHex(i,j)
			if hexV not in list1:
				$GridMapDesert.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
				hexI=indexHex(i,j)
				Global.listGround[hexI]="desert"
				#listGrass.append(hexI)
#				if hexI in listGrass and hexI<1500:  #przydatne, nie usuwac
#					listGrass.remove_at(listGrass.find(hexI))
				
			$GridMapCollision.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
			Global.listCollision.append(hexV)
	
	



