extends CharacterBody2D


@export_range(0,1000) var speed := 120
const JUMP_VELOCITY = -400.0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	get_player_input()
	move_and_slide()

func get_player_input() -> void:
	var vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# handle look direction
	

	if vector:
		# walking down screen anim
		if vector.y > 0:
			animated_sprite.play("Walk")
			modulate = Color.WHITE
			animated_sprite.flip_h = false
		# walking up screen anim
		elif vector.y < 0:
			animated_sprite.play_backwards("Walk")
			animated_sprite.flip_h = true
			modulate = Color.BLACK
	else:
		animated_sprite.play("Idle")
	
	velocity = vector * speed
	pass
