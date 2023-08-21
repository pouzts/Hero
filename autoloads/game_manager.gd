extends Node

enum GameState {TITLE, GAME, END}

var player_spawn_pos: Vector2i
var cur_scene_name:String

var has_transported: bool = false

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

func _ready() -> void:
	cur_scene_name = "final"
	game_state = GameState.TITLE

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		await quit_game()

func go_to_title() -> void:
	pass

func go_to_game() -> void:
	pass

func go_to_end() -> void:
	pass

func change_level(scene_name: String, spawn_pos: Vector2) -> void:
	if scene_name == cur_scene_name:
		return
	
	player_spawn_pos = spawn_pos
	
	match scene_name:
		"test":
			get_tree().change_scene_to_file("res://world/levels/test.tscn")
		"test2":
			get_tree().change_scene_to_file("res://world/levels/test2.tscn")
		"final":
			get_tree().change_scene_to_file("res://world/levels/FinalRoom.tscn")
		"castle":
			get_tree().change_scene_to_file("res://world/levels/Castle.tscn")
	
	cur_scene_name = scene_name
	

func find_spawn_position(scene_name: String) -> Vector2i:
	var transitions = get_tree().get_nodes_in_group("transitions")
	for transition in transitions:
		if transition is LevelTransition:
			if (transition as LevelTransition).scene_name == scene_name:
				return (transition as LevelTransition).spawn_pos
	
	return Vector2i.ZERO

func quit_game() -> void:
	paused = true
	await get_tree().create_timer(3).timeout
	get_tree().quit()
