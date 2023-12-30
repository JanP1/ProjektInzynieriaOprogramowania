extends Node

var gridBuilding
var gridMenu
var gridPath
var gridBacklight
var lastBacklight=Vector3(0,0,0)
var listCollision=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	gridBuilding=get_node("/root/Node3D/Menu/GridContainerBuilding")
	gridMenu=get_node("/root/Node3D/Menu/GridContainerMenu")
	gridPath=get_node("/root/Node3D/GridMapPath")
	gridPath=get_node("/root/Node3D/GridMapBacklight")
	pass # Replace with function body.
	
func cubeToHex(x,y):
	var x2=x
	x*=-2
	y*=2
	if x2%2==0:
		y+=1
	return Vector2(x,y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
