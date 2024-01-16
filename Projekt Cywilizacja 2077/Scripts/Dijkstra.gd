class_name Dijkstra

var distances = []
var visited = []
var prev_nodes = []
var heap = []

func _init(graph, start, end):
	var rows = graph.size()
	var cols = graph[0].size()
	distances.resize(rows)
	visited.resize(rows)
	prev_nodes.resize(rows)
	for i in range(rows):
		distances[i] = PackedFloat32Array()
		visited[i] = []
		prev_nodes[i] = PackedVector2Array()
		for j in range(cols):
			distances[i].append(INF)
			visited[i].append(false)
			prev_nodes[i].append(Vector2(-1, -1))
	heap.append({'dist': 0, 'pos': start})
	process(graph, start, end)

func process(graph, start, end):
	while heap.size() > 0:
		heap.sort_custom(_compare_pairs)
		var current_pair = heap.pop_front()
		var current_dist = current_pair['dist']
		var current_node = current_pair['pos']

		var x = int(current_node.x)
		var y = int(current_node.y)

		if visited[x][y]:
			continue

		visited[x][y] = true
		distances[x][y] = current_dist

		var neighbors = get_neighbors(current_node, graph)

		for neighbor in neighbors:
			var neighbor_dist = current_dist + graph[int(neighbor.x)][int(neighbor.y)]

			if neighbor_dist < distances[int(neighbor.x)][int(neighbor.y)]:
				heap.append({'dist': neighbor_dist, 'pos': neighbor})
				prev_nodes[int(neighbor.x)][int(neighbor.y)] = current_node
				distances[int(neighbor.x)][int(neighbor.y)] = neighbor_dist

	var path = []
	var current = end
	while current != Vector2(-1, -1):
		path.append(current)
		current = prev_nodes[int(current.x)][int(current.y)]

	path.reverse()
	return path

func get_neighbors(node, graph):
	var neighbors = []
	var directions = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1), Vector2(-1, 1), Vector2(1, 1)]

	for direction in directions:
		var neighbor = node + direction

		if neighbor.x >= 0 and neighbor.x < graph.size() and neighbor.y >= 0 and neighbor.y < graph[0].size() and graph[int(neighbor.x)][int(neighbor.y)] != 0:
			neighbors.append(neighbor)

	return neighbors

func _compare_pairs(a, b):
	if a['dist'] < b['dist']:
		return -1
	elif a['dist'] > b['dist']:
		return 1
	else:
		return 0
