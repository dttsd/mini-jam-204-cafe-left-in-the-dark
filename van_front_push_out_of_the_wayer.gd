extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#for body in get_overlapping_bodies():
		#if body is CharacterBody2D:
			#var cbody: CharacterBody2D = body
			#print(body)
			#body.velocity.y += 400
			#print("Applying force to: ", body.name, " vel=", body.velocity)
			#
			
	pass
	


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		var cbody: CharacterBody2D = body
		print(body)
		body.velocity.x = 4000
		print("Applying force to: ", body.name, " vel=", body.velocity)
		body.get_last_motion()
	pass # Replace with function body.
