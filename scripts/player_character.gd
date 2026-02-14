extends CharacterBody2D


@export_range(0,1000) var speed := 120
const JUMP_VELOCITY = -400.0

@export var light_area: Area2D
@export var darkness_damage: float = 20
@export var player_health: float = 100:
	set(value):
		# Whenever you try to change the health value, 
		# this gets called and the below code is executed
		player_health = clamp(value, 0, 100)
		# A signal can carry information too, such as health
		emit_signal("health_changed", player_health)

signal health_changed(health: float)

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	get_player_input()
	move_and_slide()
	handle_light_damage(delta)

func get_player_input() -> void:
	var vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if vector:
		# handle look direction
		animated_sprite.play("Walk")
		modulate = Color.WHITE
		animated_sprite.flip_h = false
		# walking down screen anim
		if vector.y > 0:
			pass
		# walking up screen anim
		elif vector.y < 0:
			animated_sprite.play_backwards("Walk")
			animated_sprite.flip_h = true
			modulate = Color.BLACK
	else:
		animated_sprite.play("Idle")
	
	velocity = vector * speed
	pass

func is_player_in_light():
	return (light_area.overlaps_body(self))

func handle_light_damage(delta: float):
	if not is_player_in_light():
		player_health -= darkness_damage * delta
	else:
		player_health += darkness_damage * delta * 4
		
	#print(str(player_health))
