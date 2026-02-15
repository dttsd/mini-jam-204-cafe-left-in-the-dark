extends Node2D

@export var current_items : Array[PackedScene] = []
@export var spawn_area: Area2D
#@export_subgroup("Main Category")
@export_range(0,30) var spawn_interval_min := 5
@export_range(0,30) var spawn_interval_max := 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_item()
	$Timer.wait_time = spawn_interval_min
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	spawn_item()
	$Timer.wait_time = randf_range(spawn_interval_min, spawn_interval_max)
	print("spawning next can in %f seconds" % [$Timer.wait_time])
	pass # Replace with function body.
	
func spawn_item():
	if current_items.is_empty():
		return

	var collision_shape = spawn_area.get_node("CollisionShape2D") as CollisionShape2D
	var shape := collision_shape.shape as Shape2D
	var spawn_rect := shape.get_rect()
	
	var scene : PackedScene = current_items.pick_random()
	var item : Node2D = scene.instantiate()
	
	print("rect: ",spawn_rect.position)
	
	# get global rect position start
	var rect_real_pos =  collision_shape.global_position + spawn_rect.position
	
	var pos = Vector2(
		randf_range(rect_real_pos.x, rect_real_pos.x + spawn_rect.size.x),
		randf_range(rect_real_pos.y, rect_real_pos.y + spawn_rect.size.y)
	)
	
	item.position = pos
	add_child(item)
	print("spawned ", item, item.position, item.global_position, " at ", pos)
