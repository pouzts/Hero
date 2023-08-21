class_name LevelTransition
extends Area2D

@export var scene_name: String
@export var player_spawn_pos: Vector2

@onready var spawn_pos: Vector2 = $SpawnPosition.global_position

func _ready() -> void:
	add_to_group("transitions")

func _on_body_entered(body: Node2D) -> void:
	var player = get_tree().get_first_node_in_group("player")
	if body == player and GameManager.has_transported == false:
		GameManager.change_level(scene_name, player_spawn_pos)
		GameManager.has_transported = true
	else:
		await get_tree().create_timer(1).timeout
		GameManager.has_transported = false
