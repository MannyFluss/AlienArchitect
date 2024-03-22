extends Control
#list of commands
var commands : Dictionary = {
	"echo" : "test"
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
		%CommandLine.grab_focus()
		%CommandLine.text = "/"
		%CommandLine.set_caret_column(1)
		
	if Input.is_action_just_released("close_console"):
		visible = false
		
func _on_button_pressed() -> void:
	submitCommand()

#parse the command, check if it exists
func submitCommand()->void:
	var words : Array = parse_command(%CommandLine.text)
	%CommandLine.clear()
	if words.is_empty():return
	
	if commands.has(words[0]):
		matchStringToFunction(words[0],words)
	else:
		pass

func outputMessage(message : String)->void:
	%OutputText.append_text("\n" + message)

func matchStringToFunction(commandName : String, parsedCommands : Array)->void:
	match commandName:
		"echo":
			echoCommand(parsedCommands)
		_: 
			outputMessage(commandName +" command is not implemented yet")
	
	

func echoCommand(parsedCommands : Array)->void:
	var constructMessage : String = ""
	for com : String in parsedCommands:
		constructMessage += com + " "
	outputMessage(constructMessage)
