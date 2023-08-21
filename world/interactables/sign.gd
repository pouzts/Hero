extends StaticBody2D

@export var dialogue: DialogueResource
@export var title: String

func _on_interactable_interact():
	DialogueManager.show_example_dialogue_balloon(dialogue, title)
