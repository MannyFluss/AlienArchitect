extends Control
class_name LoadGameID





func registerMe(_targetSave : String)->void:
	$MarginContainer/Button.text = _targetSave

#not safe
func _on_button_pressed() -> void:
	
	SaveSystem.currentKey = $MarginContainer/Button.text
	get_tree().change_scene_to_file("res://Scenes/GamePlayScene/main.tscn")
	pass # Replace with function body.
