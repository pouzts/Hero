class_name Interactable
extends Area2D

signal interact()

func wait_until_dialogue_done():
	GameManager.paused = true
	await DialogueManager.dialogue_ended
	GameManager.paused = false
