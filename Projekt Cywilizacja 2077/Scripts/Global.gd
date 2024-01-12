extends Node

# --------------
var gridBuilding
var gridUpdating
var gridMenu
var gridPath
var gridBacklight
var cameraNode
# --------------


#Players Money
@onready var moneyLable
var currentMoneyPlayer = 1000


var lastBacklight=Vector3(0,0,0)
var listCollision=[]
var actualGridBuilding=0
var actualGridBuildingName=""
var indexClicked=0

var breakClick=0

var listBuilding = []

# Called when the node enters the scene tree for the first time.
func _ready():
	gridBuilding=get_node("/root/Node3D/ActionMenu/GridContainerBuilding")
	gridUpdating=get_node("/root/Node3D/ActionMenu/GridContainerUpdating")
	gridMenu=get_node("/root/Node3D/ActionMenu/GridContainerMenu")
	gridPath=get_node("/root/Node3D/GridMapSetObject")
	gridBacklight=get_node("/root/Node3D/GridMapBacklight")
	cameraNode=get_node("/root/Node3D/CameraNode")
	
	#Top Menu Containing players money
	moneyLable=get_node("/root/Node3D/Menu/Control/MarginContainer/Labelndex")
	moneyLable.text = str(currentMoneyPlayer)
	
	#Connecting to the signal sent by the builder
	gridBuilding.money_changed.connect(_on_money_change)
	
	for i in range(10000):
		listBuilding.append("")
	
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
func _process(delta):
	pass


#Function called every time the value of currentMoneyPlayer changes
func _on_money_change(newMoneyValue):
	moneyLable.text = str(newMoneyValue)
