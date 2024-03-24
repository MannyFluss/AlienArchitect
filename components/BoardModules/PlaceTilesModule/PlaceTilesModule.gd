extends BoardModule



func _ready() -> void:
	myBoard.connect("boardReady",onBoardReady)
	
	
func onBoardReady()->void:
	myBoard.generateBoard(myOptions["tiles"])
