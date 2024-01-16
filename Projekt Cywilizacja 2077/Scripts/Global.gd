extends Node

# --------------
var gridBuilding
var gridUpdating
var gridMenu
var gridPath
var gridBacklight
var cameraNode
var cameraNodeCamera3D
# --------------


#Players Money
@onready var moneyLable
var currentMoneyPlayer = 1000
#Other Menu Lables
@onready var nameLable
@onready var descLable


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
		
		
	
	var graph = [[1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
			[1, 0, 1, 0, 0, 0, 1, 0, 0, 0],
			[1, 1, 0, 0, 0, 0, 1, 0, 0, 0], 
			[1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

	var start_point = [0, 0]
	var end_point = [3, 1]

	var shortest_path = dijkstra(graph, start_point, end_point)
	print("Shortest path from A to B: " + str(shortest_path))

	
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
	moneyLable.text = str(newMoneyValue) + "$"


func _on_const_it_click(name, description):
	nameLable.visible = true
	descLable.visible = true
	nameLable.text = name
	descLable.text = description

func _on_const_it_unclick():
	nameLable.visible = false
	descLable.visible = false


func get_neighbors(node, rows, cols, graph):
	var neighbors = []
	var directions = [[1, 0], [-1, 0], [0, 1], [0, -1], [-1, 1], [1, 1]]

	for direction in directions:
		var neighbor_row = node[0] + direction[0]
		var neighbor_col = node[1] + direction[1]

		if 0 <= neighbor_row and neighbor_row < rows and 0 <= neighbor_col and neighbor_col < cols and graph[neighbor_row][neighbor_col]:
			neighbors.append([neighbor_row, neighbor_col])

	return neighbors

func dijkstra(graph, start, end):
	var rows = graph.size()
	var cols = graph[0].size()
	var distances = []
	var visited = []
	var prev_nodes = []
	var heap = []
	heap.append([0, start])

	for i in range(rows):
		distances.append([])
		visited.append([])
		prev_nodes.append([])
		for j in range(cols):
			distances[i].append(INF)
			visited[i].append(false)
			prev_nodes[i].append(null)

	while heap.size() > 0:
		var current_dist = heap[0][0]
		var current_node = heap[0][1]
		heap.erase(0)

		var current_node_row = current_node[0]
		var current_node_col = current_node[1]

		if visited[current_node_row[0]][current_node_col[1]]:
			continue

		visited[current_node_row][current_node_col] = true
		distances[current_node_row][current_node_col] = current_dist

		var neighbors = get_neighbors(current_node, rows, cols, graph)

		for neighbor in neighbors:
			var neighbor_row = neighbor[0]
			var neighbor_col = neighbor[1]

			var neighbor_dist = current_dist + graph[neighbor_row][neighbor_col]

			if neighbor_dist < distances[neighbor_row][neighbor_col]:
				heap.append([neighbor_dist, neighbor])
				prev_nodes[neighbor_row][neighbor_col] = current_node
				distances[neighbor_row][neighbor_col] = neighbor_dist

	var path = []
	var current = end
	while current != null:
		path.append(current)
		current = prev_nodes[current[0]][current[1]]

	return path.invert()
