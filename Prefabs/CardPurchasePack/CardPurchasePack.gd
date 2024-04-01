extends Node3D
class_name CardPurchasePack

enum purchaseState{
	ACTIVE,
	DESTROYING,
}

var myState : purchaseState = purchaseState.ACTIVE

@export
var myResource : CardPurchaseResource

var currentlyHighlighted : bool = false

var myShopScene : ShopScene 

var chosenCard : Card

static var cardPurchase : PackedScene = preload("res://Prefabs/CardPurchasePack/CardPurchasePack.tscn")
#create resource for cardPurchasePack
func _ready() -> void:
	#make card utility generate a random card
	chosenCard = CardUtility.generateCard(CardUtility.buildingThing) as Card
	$CardContainer.add_child(chosenCard)
	chosenCard.myStatus = 5
	chosenCard.connect("mouse_entered",onHover)
	chosenCard.connect("mouse_exited",onExit)
#on card clicked, if highlighted 

func registerShopScene(shopScene : ShopScene)->void:
	myShopScene = shopScene

func onHover()->void:
	currentlyHighlighted=true
	pass

func onExit()->void:
	currentlyHighlighted=false
	pass
	
func _on_input_component_input_released(location: Vector2, timeHeld: float) -> void:
	if currentlyHighlighted and myState == purchaseState.ACTIVE:
		if myResource.cost <= myShopScene.myCurrentSave.myGameStateResource.currencyCount:
			purchaseCard()

func purchaseCard()->void:
	
	
	myState = purchaseState.DESTROYING
	chosenCard.myStatus = 0
	var tween : Tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property($CardContainer,"scale",Vector3(0.001,.001,.001),.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self,"scale",Vector3(0.001,.001,.001),.35).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)	
	
	await tween.finished
	
	myShopScene.myDeck.addCardToDeck(chosenCard)
	 
	queue_free()


static func createRandomCardPack()->CardPurchasePack:
	var toReturn : CardPurchasePack = cardPurchase.instantiate() as CardPurchasePack
	return toReturn
