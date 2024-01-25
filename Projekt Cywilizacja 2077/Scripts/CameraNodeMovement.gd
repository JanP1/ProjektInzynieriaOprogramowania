extends Node3D


# Signals --------
signal constructed_item_clicked(name:String, descr:String) # To set lables as visible and pass values
signal constructed_item_unclicked() # To set lable for name and desc as invisible

# ----------------
#Zmienione ---------------------------
@onready var clicked_hp
@onready var clicked_strength
#Zmienione ---------------------------

@export var swipe_speed : float = 0.02
var mouse=Vector2()



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

#func _process(delta):
	#var mousepos = get_viewport().get_mouse_position()
	#var result=Xray()
	#viewport_rect = get_viewport().get_visible_rect()
	#if viewport_rect.size.x*2/3>mousepos.x:
		#if "shape" in result:
			#var index=result["shape"]
			#if index in listGrass and index not in listGrassClicked:
				#var listCollision=Global.listCollision
				#var gridXY=listCollision[index]
				##var gridMapPath=Global.gridPath
				#var hexV=gridXY
				#var gridMapBacklight=Global.gridBacklight
				#var lastBacklight=Global.lastBacklight
				#
				#gridMapBacklight.set_cell_item(lastBacklight,Global.actualGridBuilding,-1)
				#gridMapBacklight.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),Global.actualGridBuilding,0)
				#Global.lastBacklight=Vector3(int(hexV[0]),0, int(hexV[1]))
	#else:
		#var gridMapBacklight=Global.gridBacklight
		#var lastBacklight=Global.lastBacklight
		#gridMapBacklight.set_cell_item(lastBacklight,1,-1)

		
#var Dijkstra = preload("res://Scripts/Dijkstra.gd")

func setVisibilityEmpty():
	var allGrids = ["gridBarracks", "gridBarracksError", "gridBuilding", "gridBuildingError", "gridBank","gridKasyno", "gridRobot", "gridLaboratory"]
	for grid in allGrids:
		Global[grid].visible = false
	
func setVisibility(activeGrid):
	# Lista wszystkich dostępnych gridów
	var allGrids = ["gridBarracks", "gridBarracksError", "gridBuilding", "gridBuildingError", "gridBank","gridKasyno", "gridRobot", "gridLaboratory"]

	# Ustawia wszystkie gridy na false
	for grid in allGrids:
		Global[grid].visible = false

	# Ustawia tylko wybrany grid na true
	Global[activeGrid].visible = true
	
		
		
var money=5
func clickOnlyGrassAndOnce(index):
	print(Global.enemyRobotMove[index])
	#print(index)
	#print(Global.listEverything[index])
	if Global.robotMove==1:
		Global.robotMove=0
		if Global.listEverything[index] in ["", "RobotWrogi","BudynekWrogi","StolicaWroga"] and  Global.listGround[index] in ["grass","desert"]:
			#print("robotmove")
			#var start_point = Vector2(0, 0)
			#var end_point = Vector2(3, 1)
			var startV=Global.indexToVector(Global.start)
			var indexV=Global.indexToVector(index)
			Global.shortestPath(startV,indexV)
	else:	
		#if index in listGrass and index not in listGrassClicked:
		#if Global.listGround[index] in ["grass","desert"]:
		if Global.listEverything[index] in ["RobotDefensywny","RobotOfensywny"]:# and Global.listGround[index] in ["grass","desert"]:
			#Zmienione --------------------------------------------------------------------------------
			clicked_hp = Global.listHP[index]
			clicked_strength = Global.listStrength[index]
			var opis = "Hp: " + str(clicked_hp) + " Strength: " + str(clicked_strength)
			#Zmienione --------------------------------------------------------------------------------
			
			constants(index)
			setVisibility("gridRobot")
			Global._on_const_it_click("Robot", opis)
		elif Global.listGround[index] in ["grass","desert"]:
			#var listCollision=Global.listCollision
			#var gridXY=listCollision[index]
			#var gridMapPath=Global.gridPath
			#var hexV=gridXY
			#if money>0:
				#gridMapPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),Global.actualGridBuilding,0)
				#if Global.actualGridBuildingName=="Kostka":
					#money-=1
				#elif Global.actualGridBuildingName=="Okrąg":
					#money-=3
			#print(index)
			
			constants(index)
			
			if Global.listEverything[index] not in ["", "water"]:
				#Zmienione --------------------------------------------------------------------------------
				clicked_hp = Global.listHP[index]
				clicked_strength = Global.listStrength[index]
				var opis = "Hp: " + str(clicked_hp) + " Strength: " + str(clicked_strength)
				#Zmienione --------------------------------------------------------------------------------
				
				
				if Global.listEverything[index]=="StolicaMoja":
					Global._on_const_it_click("StolicaMoja", opis)
					setVisibilityEmpty()
				elif Global.listEverything[index]=="StolicaWroga":
					Global._on_const_it_click("StolicaWroga", opis)
					setVisibilityEmpty()
				elif Global.listEverything[index]=="BudynekWrogi":
					Global._on_const_it_click("BudynekWrogi", opis)
					setVisibilityEmpty()
				elif Global.listEverything[index]=="RobotWrogi":
					Global._on_const_it_click("RobotWrogi", opis)
					setVisibilityEmpty()
				
				elif Global.listEverything[index]=="RobotMove":
					setVisibility("gridBuildingError")
					
				elif Global.listEverything[index]=="Kasyno":
					#Global.gridUpdating.get_node("Button").text = "Ulepszenie Kostki"
					Global._on_const_it_click("Kasyno", opis)
					setVisibility("gridKasyno")
				
				elif Global.listEverything[index]=="Bank":
					#Global.gridUpdating.get_node("Button").text = "Ulepszenie Kostki"
					Global._on_const_it_click("Bank", opis)
					setVisibility("gridBank")
				
				elif Global.listEverything[index]=="Laboratorium":
					#Global.gridUpdating.get_node("Button").text = "Ulepszenie Kostki"
					Global._on_const_it_click("Laboratorium", opis)
					setVisibility("gridLaboratory")
				
				elif Global.listEverything[index]=="Koszary":
					Global._on_const_it_click("Koszary", opis)
					var directions
					var node=Global.indexToVector(index)
					if int(node[0])%2!=1:
						
						directions = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1), Vector2(1, 1), Vector2(-1, 1)]
					else:
						
						directions = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1), Vector2(-1, -1), Vector2(1, -1)]
					var barrackError=1
					#print(index)
					for direction in directions:
						var neighbor = node + direction
						var neighborIndex=Global.vectorToIndex(neighbor)#neighbor[0]*40+neighbor[1]
						#print(neighborIndex)
						if Global.listEverything[neighborIndex]=="":
							barrackError=0
							Global.barrackNeighbor=int(neighborIndex)
							break
					if barrackError==1:
						#Global.gridBarracks.visible=false
						#Global.gridBarracksError.visible=true
						setVisibility("gridBarracksError")
					if barrackError==0:
						setVisibility("gridBarracks")
				else:
					Global._on_const_it_click("Niezidentyfikowany obiekt", "...")
					
					#Global.actualGridBuildingName="Kostka"
					#Global.gridUpdating.visible=true
					#Global.gridBarracks.visible=false
					#Global.gridBuilding.visible=false
					#Global.gridBarracksError.visible=false
				
			elif Global.listGround[index] in ["grass"]:
				setVisibility("gridBuilding")
				Global._on_const_it_unclick()
			else:
				setVisibilityEmpty()
				#Global.actualGridBuildingName=listBuilding[index]
		
		
			
func constants(index):
	var hexV=Global.listCollision[index]
	Global.gridBacklight.set_cell_item(Global.lastBacklight,1,-1)
	Global.gridBacklight.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	Global.lastBacklight=Vector3(int(hexV[0]),0, int(hexV[1]))
	Global.indexClicked=index
				
		
		#listGrassClicked.append(index)
		
		
