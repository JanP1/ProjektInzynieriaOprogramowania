extends GridMap
#
#var Dijkstra = preload("res://Scripts/Dijkstra.gd")
## Called when the node enters the scene tree for the first time.
#func _ready():
	#var INF = float('inf')
#
	#var graph = [
	#[1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
	#[1, 0, 1, 0, 0, 0, 1, 0, 0, 0],
	#[1, 1, 0, 0, 0, 0, 1, 0, 0, 0],
	#[1, 1, 1, 1, 1, 1, 1, 0, 0, 0],
	#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	#[0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
	#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	#]
#
	#var start_point = Vector2(0, 0)
	#var end_point = Vector2(3, 1)
	#var dijkstra = Dijkstra.new(graph, start_point, end_point)
	#var shortest_path = dijkstra.process(graph, start_point, end_point)
	#var shortest_path2 = dijkstra.process(graph, Vector2(0,0), Vector2(1,2))
	#for i in shortest_path:
		#
		#var hexV=Global.cubeToHex(int(i[0]),int(i[1]))
		#Global.gridGrass.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	#for i in shortest_path2:
		#
		#var hexV=Global.cubeToHex(int(i[0]),int(i[1]))
		#Global.gridGrass.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,0)
	#print(shortest_path)
	#print(shortest_path2)
	#print(graph)
	
	#var shortest_path = dijkstra(graph, start_point, end_point)   
	#print("Najkrótsza ścieżka od A do B:", shortest_path)


