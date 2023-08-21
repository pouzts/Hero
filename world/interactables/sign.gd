extends StaticBody2D

@export var dialogue: DialogueResource
@export var title: String

@onready var interactable: Interactable = $Interactable

const BALLON = preload("res://dialogue/balloon.tscn")

func _on_interactable_interact():
	var ballon: Node = BALLON.instantiate()
	get_tree().current_scene.add_child(ballon)
	ballon.start(dialogue, title)
	interactable.wait_until_dialogue_done()
