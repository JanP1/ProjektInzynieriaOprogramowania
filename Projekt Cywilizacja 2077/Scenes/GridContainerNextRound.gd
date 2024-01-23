extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button
	button.connect("pressed", Callable(self, "_on_button_pressed"))


func _on_button_pressed():
			
	checkIfColided()	
	Global.listEverything="RobotWrogi"
	var newList[200]=[(1,2),(2,2),(3,2)]
	shotest_paht[1:4] w stronę stolicy
	checkIfColided_Enemy(newList)
	for i in range(Global.listRobotMove.size()):
		Global.deleteLastRobotMove(i)
	
	var money=0
	Global.currentBankPlayer=1000
	var bank=0
	var lab=false
	
	var len = min(Global.listEverything.size(), Global.listUpgrading.size())
	for i in range(len):
		var element = Global.listEverything[i]
		var upgrade = Global.listUpgrading[i]
	#for element in Global.listEverything and for upgrade in Global.listUpgrading:
		match element:
			"Kasyno":
				money+=upgrade*upgrade*10
				#match upgrade:
					#1:
						#money+=10
			"Bank":
				bank +=200*upgrade
			"Laboratorium":
				lab=true
				
	if lab==false:
		Global.RobotDefensywnyUpgrade=1
		Global.RobotOfensywnyUpgrade=1
		Global.RobotRangeUpgrade=1
				
	Global._on_money_change(money)		
	Global._on_bank_change(bank)	
	
	
	
	
		
func checkIfColided():
	for i in range(Global.listRobotMove.size()):
		var bestMove=-1
		var list_of_moves = Global.listRobotMove[i]
		if list_of_moves.size() >0:
			for j in list_of_moves:
				var moved_to_position = int(Global.vectorToIndex(j))
				#var WAZNA=Global.listEverything[moved_to_position]
				if Global.listEverything[moved_to_position] in ["RobotWrogi","BudynekWrogi","StolicaWroga"]:
					while(Global.listHP[moved_to_position]>0 and Global.listHP[i]>0):
						Global.listHP[moved_to_position] -= Global.listHP[i]/10+Global.listStrength[i]
						if(Global.listHP[moved_to_position] <= 0):
							break
						Global.listHP[i] -= Global.listHP[moved_to_position]/10+Global.listStrength[moved_to_position]
					
					if(Global.listHP[moved_to_position] <= 0):
						Global.listHP[moved_to_position] = 0
						Global.listStrength[moved_to_position] = 0
						Global.listEverything[moved_to_position] = ""
						
						var hexV=Global.cubeToHex(int(Global.indexToVector(moved_to_position)[0]),int(Global.indexToVector(moved_to_position)[1]))
						Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
						
					if(Global.listHP[i] <= 0):
						Global.listHP[i] = 0
						Global.listStrength[i] = 0
						Global.listEverything[i] = ""
						var hexV=Global.cubeToHex(int(Global.indexToVector(i)[0]),int(Global.indexToVector(i)[1]))
						Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
						#Global.deleteLastRobotMove(i)
						return false
				elif Global.listEverything[moved_to_position]=="RobotMove":
					bestMove=moved_to_position
			if bestMove!=-1:
				movingRobot(i,bestMove)
						
				
func movingRobot(start,end):
	var nameRobot=Global.listEverything[start]
	var indexItem = Global.get_item_index_by_name(Global.gridPath.mesh_library, nameRobot)
	var hexV=Global.cubeToHex(int(Global.indexToVector(start)[0]),int(Global.indexToVector(start)[1]))
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),indexItem,-1)
	hexV=Global.cubeToHex(int(Global.indexToVector(end)[0]),int(Global.indexToVector(end)[1]))
	Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),indexItem,0)
	#var x=Global.listEverything[start]
	Global.listEverything[end]=Global.listEverything[start]
	Global.listHP[end]=Global.listHP[start]
	Global.listStrength[end]=Global.listStrength[start]
	
	Global.listEverything[start]=""
	Global.listHP[start]=""
	Global.listStrength[start]=""
	
	#print(end)
	#print(Global.listEverything[end])
	setVisibility()
	


		
func checkIfColided_Enemy(listRobotMove):
	for i in range(listRobotMove.size()):
		var bestMove=-1
		var list_of_moves = listRobotMove[i]
		if list_of_moves.size() >0:
			for j in list_of_moves:
				var moved_to_position = int(Global.vectorToIndex(j))
				#var WAZNA=Global.listEverything[moved_to_position]
				if Global.listEverything[moved_to_position] not in ["","RobotWrogi","BudynekWrogi","StolicaWroga"]:
					while(Global.listHP[moved_to_position]>0 and Global.listHP[i]>0):
						Global.listHP[moved_to_position] -= Global.listHP[i]/10+Global.listStrength[i]
						if(Global.listHP[moved_to_position] <= 0):
							break
						Global.listHP[i] -= Global.listHP[moved_to_position]/10+Global.listStrength[moved_to_position]
					
					if(Global.listHP[moved_to_position] <= 0):
						Global.listHP[moved_to_position] = 0
						Global.listStrength[moved_to_position] = 0
						Global.listUpgrading[moved_to_position] = 1
						Global.listEverything[moved_to_position] = ""
						
						var hexV=Global.cubeToHex(int(Global.indexToVector(moved_to_position)[0]),int(Global.indexToVector(moved_to_position)[1]))
						Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
						
					if(Global.listHP[i] <= 0):
						Global.listHP[i] = 0
						Global.listStrength[i] = 0
						Global.listEverything[i] = ""
						var hexV=Global.cubeToHex(int(Global.indexToVector(i)[0]),int(Global.indexToVector(i)[1]))
						Global.gridPath.set_cell_item(Vector3i(int(hexV[0]),0, int(hexV[1])),0,-1)
						#Global.deleteLastRobotMove(i)
						return false
				elif Global.listEverything[moved_to_position]=="RobotMove":
					bestMove=moved_to_position
			if bestMove!=-1:
				movingRobot(i,bestMove)


	
func setVisibility():
	# Lista wszystkich dostępnych gridów
	var allGrids = ["gridBarracks", "gridBarracksError", "gridBuilding", "gridBuildingError", "gridBank","gridKasyno", "gridRobot", "gridLaboratory"]

	# Ustawia wszystkie gridy na false
	for grid in allGrids:
		Global[grid].visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
