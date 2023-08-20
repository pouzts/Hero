extends CharacterBody2D

const RUN_SPEED: float = 250.0
const SPEED: float = 200.0

var dir: Vector2 = Vector2.ZERO

@onready var anim_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	anim_tree.active = true

func _physics_process(_delta: float) -> void:
	dir = Input.get_vector("left", "right", "up", "down").normalized()
	var move_speed: float = RUN_SPEED if Input.is_action_pressed("run") else SPEED
	
	velocity = dir * move_speed
	
	set_animation()
	
	position.x = roundf(position.x)
	position.y = roundf(position.y)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		print("Interact")
		pass

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
