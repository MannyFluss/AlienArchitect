extends Event



func _ready() -> void:
	%EventText.text = "seed result is " + str(myScene.myCurrentSave.randomSeed) + "
		\n" + "this is event 2"
		 


#this is where event functionality would be added
func _on_confirm_event_pressed() -> void:
	endEvent()
	pass # Replace with function body.
