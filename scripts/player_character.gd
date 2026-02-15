extends CharacterBody2D


@export_range(0,1000) var speed := 120
const JUMP_VELOCITY = -400.0

var holding_item: bool = false

@export var van: StaticBody2D
@onready var van_interact_area:Area2D = van.get_node("InteractArea")

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
	if holding_item == true:
		# check if overlapping van, and add item
		if $GrabArea.overlaps_area(van_interact_area):
			add_item_to_van()

		pass

	get_player_input()
	move_and_slide()
	handle_light_damage(delta)
	
func add_item_to_van():
	# get item reference from hands
	var item: Area2D = $Hands.get_child(0)
	
	
	# move item to van
	item.reparent(van)
	
	
	
	var tween = get_tree().create_tween()
	tween.tween_property(item, "position", Vector2.ZERO, .3)
	tween.tween_property(item, "modulate", Color(1,1,1,0), .3)
	tween.tween_callback(func(): item.queue_free())

	# handle what item type
	print("item class: ", item.get_class())
	match item.get_script().get_global_name():
		"item_beans":
			print("BEANS!")
			# add to bean value
			Global.awakeness += 30
		"item_fuel_can":
			print("FUEL!")
			# increment van fuel
			Global.van_fuel += 30
		_:
			print("UNKNOWN ITEM!")
	

	
	# remove item from hands
	holding_item = false
	pass
	
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
			#tween.tween_callback(func(): print("tween complete"))

			closest_item.reparent($Hands)
			
			# remove item from item group to prevent re-grabbing and null error when queue_free later
			closest_item.remove_from_group("item")
			
			holding_item = true
			#closest_item.rotate(5)
			
		
		


func get_player_input() -> void:
	var vector: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if vector:
		# handle look direction

		# walking down screen anim
		if vector.y >= 0:
			animated_sprite.play("Walk")
			self_modulate = Color.WHITE
			animated_sprite.flip_h = false
			pass
		# walking (away) up screen anim (make character dark)
		elif vector.y < 0:
			animated_sprite.play("Walk_Away")
			#animated_sprite.flip_h = true
			#self_modulate = Color.BLACK
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
