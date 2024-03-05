extends CanvasLayer
class_name LevelUI



#this script should only be cosmetic and reactive to other changes

func updateMunicipalityPoints(points:int)->void:
	%CurrentProgressLabel.text = "Current Progress: "+str(points)

func updateQuotaLabel(quotaAmount:int)->void:
	%QuotaLabel.text = "Quota: "+str(quotaAmount) 

func updateBluePrintLabel(amount:int)->void:
	%BlueprintLabel.text = "BluePrints: "+str(amount)
	
func _on_game_state_new_municipality_score(amount: int) -> void:
	updateMunicipalityPoints(amount)

func _on_game_state_quota_set(amount: int) -> void:
	updateQuotaLabel(amount)

func _on_game_state_blue_print_count_set(amount: int) -> void:
	updateBluePrintLabel(amount)
	pass # Replace with function body.
