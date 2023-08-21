class_name Player
extends CharacterBody2D

const RUN_SPEED: float = 300.0
const SPEED: float = 200.0

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var interact_trig: Area2D = $Direction/InteractableTrigger

var dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	dir = Vector2.DOWN
	set_animation()
	set_player_pos(GameManager.player_spawn_pos)
	add_to_group("player")
	anim_tree.active = true

func _physics_process(_delta: float) -> void:
	dir = Input.get_vector("left", "right", "up", "down").normalized()
	var move_speed: float = RUN_SPEED if Input.is_action_pressed("run") else SPEED
	
	velocity = dir * move_speed
	
	# if it works, it works
	position.x = roundf(position.x)
	position.y = roundf(position.y)
	
	set_animation()
	
	move_and_slide()

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("interact"):
		var interactables = interact_trig.get_overlapping_areas()
		if interactables.size() > 0 and interactables[0] is Interactable:
			(interactables[0] as Interactable).interact.emit()
			return

func set_animation() -> void:
	if dir != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", dir)
		anim_tree.set("parameters/Move/blend_position", dir)
	
	if velocity != Vector2.ZERO:
		anim_tree.set("parameters/conditions/idle", false)
		anim_tree.set("parameters/conditions/is_moving", true)
	else:
		anim_tree.set("parameters/conditions/idle", true)
		anim_tree.set("parameters/conditions/is_moving", false)

func set_player_pos(pos: Vector2i):
	position.x = pos.x
	position.y = pos.y
