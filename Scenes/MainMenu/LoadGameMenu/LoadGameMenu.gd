extends CanvasLayer
class_name LoadGameMenu

# Called when the node enters the scene tree for the first time.
const LOAD_GAME_PATH : String = "res://Scenes/MainMenu/LoadGameMenu/LoadGameButtons/LoadGameID.tscn"

func _ready() -> void:
	#for file
	for key : String in SaveSystem.getAllSaveKeys():
		var newLoadButton:LoadGameID = load(LOAD_GAME_PATH).instantiate() as LoadGameID
		if newLoadButton:
			newLoadButton.registerMe(key)
			%LoadButtons.add_child(newLoadButton)
			
	
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	queue_free()
