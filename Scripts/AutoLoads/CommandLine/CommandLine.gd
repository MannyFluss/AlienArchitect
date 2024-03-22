extends Control
#list of commands
var commands : Dictionary = {
	"echo" : "test",
	"drawCard" : "",
	"clear" : ""
}


func _ready() -> void:
	visible = false

func parse_command(text: String) -> Array:
	var regex : RegEx = RegEx.new()
	# Pattern explanation:
	# ^\s*\/(\w+): Matches the initial slash and the first word, capturing the word
	# (\w+): Captures each subsequent word
	var pattern :String = "^\\s*/(\\w+)|(\\w+)"
	regex.compile(pattern)

	var results :Array = []
	var matches : Array= regex.search_all(text)
	
	for item : RegExMatch in matches:
		var match_strings : PackedStringArray = item.get_strings()

		if match_strings[1] != "":
			results.append(match_strings[1])
		elif match_strings.size() > 2 && match_strings[2] != "":
			results.append(match_strings[2])
	return results


func _physics_process(delta: float) -> void:
	if Input.is_action_just_released("open_console"):
		visible = true
		#on open
		clearCommandLine()
	if Input.is_action_just_released("close_console"):
		visible = false
	if Input.is_action_just_pressed("submit_console"):
		submitCommand()

func _on_button_pressed() -> void:
	submitCommand()


func clearCommandLine()->void:
	%CommandLine.grab_focus()
	%CommandLine.text = "/"
	%CommandLine.set_caret_column(1)

func submitCommand()->void:
	var words : Array = parse_command(%CommandLine.text)
	if words.is_empty():return
	clearCommandLine()
	matchStringToFunction(words[0],words)


func outputMessage(message : String)->void:
	%OutputText.append_text("\n" + message)

func matchStringToFunction(commandName : String, parsedCommands : Array)->void:
	match commandName:
		"echo":
			echoCommand(parsedCommands)
		"drawCard":
			drawCardCommand()
		"clear":
			%OutputText.clear()
		"loadDeck":
			loadDeck(parsedCommands)
		"saveDeck":
			saveDeck(parsedCommands)
		_: 
			outputMessage(commandName +" command is not implemented yet")
			
func saveDeck(parsedCommands : Array)->void:
	if parsedCommands.size()<2:
		outputMessage("saveDeck command requires save path as second argument")
		return
	var myDeck : Deck = get_tree().get_first_node_in_group("Decks") as Deck
	if Deck==null:
		outputMessage("Deck not found ... Aborting Command")
		return
	myDeck.saveDeck(parsedCommands[1])
	
func loadDeck(parsedCommands : Array)->void:
	if parsedCommands.size()<2:
		outputMessage("loadDeck command requires save path as second argument")
		return
	var myDeck : Deck = get_tree().get_first_node_in_group("Decks") as Deck
	if Deck==null:
		outputMessage("Deck not found ... Aborting Command")
		return
	outputMessage("loading Deck")
	
	myDeck.createDeckFromSave(parsedCommands[1])
	pass

func drawCardCommand()->void:
	var myDeck : Deck = get_tree().get_first_node_in_group("Decks") as Deck
	if Deck==null:
		outputMessage("Deck not found ... Aborting Command")
		return
	myDeck.drawRandomCardToHand()
	outputMessage("Drawing card...")
	
	

func findFirstNodeOfType(root: Node, type : String ) -> Node:
	if root.get_class() == type:
		return root
	for child in root.get_children():
		var found: = findFirstNodeOfType(child, type)
		if found:
			return found
			
	
	return null

func echoCommand(parsedCommands : Array)->void:
	var constructMessage : String = ""
	for com : String in parsedCommands:
		constructMessage += com + " "
	outputMessage(constructMessage)


