extends CharacterBody2D


@export_range(0,1000) var speed := 120
const JUMP_VELOCITY = -400.0

var holding_item: bool = false

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
	
func _input(event: InputEvent) -> void:
	# pressed e or space or enter
	if event.is_action_pressed("ui_accept"):
		print("player pressed ", event.as_text())
		
		if holding_item:
			return
		
		# check if any items are touching area
		
		var overlapping_areas: Array[Area2D] = $GrabArea.get_overlapping_areas()
		var overlapping_items: Array[Area2D] = overlapping_areas.filter(func(el: Area2D): return el.is_in_group("item"))
		
		# check if any items in area
		if not overlapping_items.is_empty():
			#if so, grab nearest
			var closest_item: Area2D = null
			var closest_dist_sqrd: float = 999999
			for item in overlapping_items:
				var dist = global_position.distance_squared_to(item.global_position)
				if closest_dist_sqrd == null or dist < closest_dist_sqrd:
					closest_dist_sqrd = dist
					closest_item = item
			
			
			var tween = get_tree().create_tween()
			tween.tween_property(closest_item, "position", Vector2.ZERO, .25)
			tween.tween_callback(func(): print("tween complete"))

			closest_item.reparent($Hands)
			holding_item = true
			#closest_item.rotate(5)
			
		
		


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


func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("item"):
		#print("collided with item")
		#area.modulate = Color(2,2,2,1)
		
	pass # Replace with function body.
