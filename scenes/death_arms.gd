extends Node2D

@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#play_cutscene()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_cutscene():
	var armscene = preload("res://scenes/creepy_arm.tscn")
	
	var arm_spawn_loc = $Path2D/ArmSpawnLocation
	
	var num_of_arms:float = 10
	
	for i in range(num_of_arms):
		# load arm
		var arm: Node2D = armscene.instantiate()
		var playerPos = player.global_position
		
		add_child(arm)
		
		var progress_ratio = float(i / num_of_arms)
		arm_spawn_loc.progress_ratio = progress_ratio
		#arm.position += Vector2.RIGHT * 50 * i
		arm.global_position = arm_spawn_loc.global_position
		
		arm.look_at(playerPos)
	
		var tween = create_tween()
		tween.tween_property(arm, "global_position", playerPos, randf_range(5,5.5))
	pass
