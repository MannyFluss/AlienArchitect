extends Event



func _ready() -> void:
	%EventText.text = "seed result is " + str(rand_from_seed(myScene.myCurrentSave.randomSeed)[0]) + "
		\n" + "this is event 1"
		 


#this is where event functionality would be added
func _on_confirm_event_pressed() -> void:
	endEvent()
	pass # Replace with function body.
