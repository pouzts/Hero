class_name LevelTransition
extends Area2D

@export var scene_name: String

@onready var spawn_pos: Vector2 = $SpawnPosition.global_position

func _ready() -> void:
	add_to_group("transitions")

func _on_body_entered(body: Node2D) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if body == player and GameManager.has_transported == false:
		GameManager.change_level(scene_name)
		GameManager.has_transported = true
		var spawn_location: Vector2i = find_transition_position(scene_name)
		
		GameManager.player_spawn_pos = spawn_location
	else:
		GameManager.has_transported = false

func find_transition_position(scene_name: String) -> Vector2i:
	var transitions = get_tree().get_nodes_in_group("transitions")
	for transition in transitions:
		if transition is LevelTransition:
			if (transition as LevelTransition).scene_name == scene_name:
				return (transition as LevelTransition).spawn_pos
	
	return Vector2i.ZERO
