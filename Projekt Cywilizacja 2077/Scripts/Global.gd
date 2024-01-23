extends Node

# --------------
var gridBuilding
var gridUpdating
var gridRobot
var gridBarracks
var gridLaboratory
var gridBank
var gridKasyno
var gridBarracksError
var gridBuildingError
var gridDesert
var gridGrass
var gridWater
var gridMenu
var gridPath
var gridBacklight
var cameraNode
var cameraNodeCamera3D
# --------------
var robotMove=0
var barrackNeighbor
var mapMovement=[]
var start

#Players Money
@onready var moneyLable
var moneyLable2
var currentMoneyPlayer = 1000
var currentBankPlayer = 1000
#Other Menu Lables
@onready var nameLable
@onready var descLable

var RobotDefensywnyUpgrade=1
var RobotOfensywnyUpgrade=1
var RobotRangeUpgrade=1

#var upgradeStrength=1
#var upgradeHP=1
#var upgradeRange=1

var lastBacklight=Vector3(0,0,0)
var listCollision=[]
var listEverything=[]
var listUpgrading=[]
var listHP=[]
var listRange=[]
var listStrength=[]
var listRobotMove=[]
var listGround=[]
var actualGridBuilding=0
var actualGridBuildingName=""
var indexClicked=0

var Centrum
var breakClick=0
var enemyRobotMove=[]

var listBuilding = []

# Called when the node enters the scene tree for the first time.
var map_scene = preload("res://Scenes/map.tscn")
func _ready():
	var player = map_scene.instantiate()
	gridDesert=player.get_node("/root/Node3D/GridMapDesert")
	gridWater=player.get_node("/root/Node3D/GridMapWater")
	gridGrass=player.get_node("/root/Node3D/GridMapGrass")
	gridBuilding=player.get_node("/root/Node3D/ActionMenu/GridContainerBuilding")
	gridRobot=player.get_node("/root/Node3D/ActionMenu/GridContainerRobot")
	gridBarracks=player.get_node("/root/Node3D/ActionMenu/GridContainerBarracks")
	gridLaboratory=player.get_node("/root/Node3D/ActionMenu/GridContainerLaboratory")
	gridBank=player.get_node("/root/Node3D/ActionMenu/GridContainerBank")
	gridKasyno=player.get_node("/root/Node3D/ActionMenu/GridContainerKasyno")
	gridBarracksError=player.get_node("/root/Node3D/ActionMenu/GridContainerBarracksError")
	gridBuildingError=player.get_node("/root/Node3D/ActionMenu/GridContainerBuildingError")
	gridUpdating=player.get_node("/root/Node3D/ActionMenu/GridContainerUpdating")
	gridMenu=player.get_node("/root/Node3D/ActionMenu/GridContainerMenu")
	gridPath=player.get_node("/root/Node3D/GridMapSetObject")
	gridBacklight=player.get_node("/root/Node3D/GridMapBacklight")
	cameraNode=player.get_node("/root/Node3D/CameraNode")
	cameraNodeCamera3D=player.get_node("/root/Node3D/CameraNode/Camera3D")
	
	#Top Menu Containing players money
	#moneyLable=get_node("/root/Node3D/Menu/Control/MarginContainer/LabelIndex")
	moneyLable=player.get_node("/root/Node3D/Menu/Control/GridContainer/LabelIndex")
	moneyLable2=player.get_node("/root/Node3D/Menu/Control/GridContainer/LabelIndex2")
	#Item clicked
	nameLable = player.get_node("/root/Node3D/Menu/Control/MarginContainer4/LabelName")
	descLable = player.get_node("/root/Node3D/Menu/Control/MarginContainer3/Description")
	#moneyLable.text = str(currentMoneyPlayer) + "$"
	
	#Connecting to the signals
	#gridBuilding.money_changed.connect(_on_money_change)
	#cameraNode.constructed_item_clicked.connect(_on_const_it_click)
	#cameraNode.constructed_item_unclicked.connect(_on_const_it_unclick)
	#Global._on_money_change(1000)
	#for i in range(10000):
		#listBuilding.append("")
		
var Dijkstra = preload("res://Scripts/Dijkstra.gd")
func shortestPath(start2,end):
	var index=vectorToIndex(start2)
	deleteLastRobotMove(index)
		
	var dijkstra = Dijkstra.new(mapMovement, start2, end)
	var shortest_path = dijkstra.process(mapMovement, start2, end)
	#print(shortest_path)
	if shortest_path.size()<=4+Global.RobotRangeUpgrade:
		shortest_path=shortest_path.slice(1,shortest_path.size())
	else:
		shortest_path=shortest_path.slice(1,4+Global.RobotRangeUpgrade)
	#shortest_path
	for i in shortest_path:
		if Global.listEverything[vectorToIndex(i)] not in ["RobotWrogi","BudynekWrogi"]:
			Global.listEverything[vectorToIndex(i)]="RobotMove"
		var hexV=Global.cubeToHex(int(i[0]),int(i[1]))
		Global.gridWater.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	Global.listRobotMove[index]=shortest_path ######################################################################TUTAJ
	
	#print(shortest_path)
	#print(Global.listRobotMove[index])

func deleteLastRobotMove(index):
	#print(Global.listRobotMove[index])
	for i in Global.listRobotMove[index]:
		var ok=1
		var index2=0
		for j in Global.listRobotMove:
			if index!=index2:
				for k in j:
					if k==i:
						ok=0
			index2+=1
		if ok==1:
			if Global.listEverything[vectorToIndex(i)] in ["RobotMove"]:
				Global.listEverything[vectorToIndex(i)]=""
			var hexV=Global.cubeToHex(int(i[0]),int(i[1]))
			Global.gridWater.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
	Global.listRobotMove[index]=[]
		
	
func indexToVector(x):
	#print(Vector2(int(x/40),x%40))
	return Vector2(int(x/40),x%40)

func vectorToIndex(x):
	return x[0]*40+x[1]
	
func indexHex(x,y):
	return y+x*40		
#Zmienione --------------------------------------------------------------------------------

#Zmienione --------------------------------------------------------------------------------




func cubeToHex(x,y):
	var x2=x
	x*=-2
	y*=2
	if x2%2==0:
		y+=1
	return Vector2(x,y)
	
func get_item_index_by_name(mesh_library, item_name):
	var count = mesh_library.get_item_list().size()
	for i in range(count):
		if mesh_library.get_item_name(i) == item_name:
			return i
	return -1

# Called every frame. 'delta' is the elapsed time since the previous frame.


#Function called every time the value of currentMoneyPlayer changes
func _on_money_change(priceOfSelected):
	Global.currentMoneyPlayer += priceOfSelected
	var newMoneyValue=Global.currentMoneyPlayer
	moneyLable.text = str(newMoneyValue) + "$"

func _on_bank_change(priceOfSelected):
	Global.currentBankPlayer += priceOfSelected
	var newMoneyValue=Global.currentBankPlayer
	moneyLable2.text = str(newMoneyValue) + "$"

func _on_const_it_click(name, description):
	nameLable.visible = true
	descLable.visible = true
	nameLable.text = name
	descLable.text = description

func _on_const_it_unclick():
	nameLable.visible = false
	descLable.visible = false

