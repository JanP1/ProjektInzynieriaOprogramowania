extends Node

# --------------
var gridBuilding
var gridUpdating
var gridRobot
var gridBarracks
var gridBarracksError
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
var currentMoneyPlayer = 1000
#Other Menu Lables
@onready var nameLable
@onready var descLable


var lastBacklight=Vector3(0,0,0)
var listCollision=[]
var listEverything=[]
var listGround=[]
var actualGridBuilding=0
var actualGridBuildingName=""
var indexClicked=0

var breakClick=0

var listBuilding = []

# Called when the node enters the scene tree for the first time.
func _ready():
	gridDesert=get_node("/root/Node3D/GridMapDesert")
	gridWater=get_node("/root/Node3D/GridMapWater")
	gridGrass=get_node("/root/Node3D/GridMapGrass")
	gridBuilding=get_node("/root/Node3D/ActionMenu/GridContainerBuilding")
	gridRobot=get_node("/root/Node3D/ActionMenu/GridContainerRobot")
	gridBarracks=get_node("/root/Node3D/ActionMenu/GridContainerBarracks")
	gridBarracksError=get_node("/root/Node3D/ActionMenu/GridContainerBarracksError")
	gridUpdating=get_node("/root/Node3D/ActionMenu/GridContainerUpdating")
	gridMenu=get_node("/root/Node3D/ActionMenu/GridContainerMenu")
	gridPath=get_node("/root/Node3D/GridMapSetObject")
	gridBacklight=get_node("/root/Node3D/GridMapBacklight")
	cameraNode=get_node("/root/Node3D/CameraNode")
	cameraNodeCamera3D=get_node("/root/Node3D/CameraNode/Camera3D")
	
	#Top Menu Containing players money
	moneyLable=get_node("/root/Node3D/Menu/Control/MarginContainer/LabelIndex")
	
	#Item clicked
	nameLable = get_node("/root/Node3D/Menu/Control/MarginContainer4/LabelName")
	descLable = get_node("/root/Node3D/Menu/Control/MarginContainer3/Description")
	moneyLable.text = str(currentMoneyPlayer) + "$"
	
	#Connecting to the signals
	gridBuilding.money_changed.connect(_on_money_change)
	cameraNode.constructed_item_clicked.connect(_on_const_it_click)
	cameraNode.constructed_item_unclicked.connect(_on_const_it_unclick)
	
	for i in range(10000):
		listBuilding.append("")
		
var Dijkstra = preload("res://Scripts/Dijkstra.gd")
func shortestPath(start2,end):
	var dijkstra = Dijkstra.new(mapMovement, start2, end)
	var shortest_path = dijkstra.process(mapMovement, start2, end)
	print(shortest_path)
	for i in shortest_path:
		var hexV=Global.cubeToHex(int(i[0]),int(i[1]))
		Global.gridWater.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	
func indexToVector(x):
	print(Vector2(int(x/40),x%40))
	return Vector2(int(x/40),x%40)

		

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
func _on_money_change(newMoneyValue):
	moneyLable.text = str(newMoneyValue) + "$"


func _on_const_it_click(name, description):
	nameLable.visible = true
	descLable.visible = true
	nameLable.text = name
	descLable.text = description

func _on_const_it_unclick():
	nameLable.visible = false
	descLable.visible = false

