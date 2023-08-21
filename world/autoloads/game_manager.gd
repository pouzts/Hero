extends Node

enum GameState {TITLE, GAME, END}

var is_paused: bool = false
var paused: bool:
	get:
		return is_paused
	set(value):
		is_paused = value
		get_tree().paused = is_paused

var state: GameState
var game_state: GameState:
	get:
		return state
	set(value):
		state = value
		match state:
			GameState.TITLE:
				go_to_title()
			GameState.GAME:
				go_to_game()
			GameState.END:
				go_to_end()

func _ready():
	game_state = GameState.TITLE

func _init(event: InputEvent) -> void:
	if event.is_action("exit"):
		paused = not paused

func go_to_title():
	pass

func go_to_game():
	pass

func go_to_end():
	pass
