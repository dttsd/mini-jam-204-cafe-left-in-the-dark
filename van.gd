extends StaticBody2D

@export var speed: float = 20

@onready var timer := $Timer
@onready var radiusLight := $RadiusLight
@onready var headLights := $HeadLights

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.constant_linear_velocity = Vector2.RIGHT * speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2.RIGHT * speed * delta
	pass


func _on_timer_timeout() -> void:
	var rand_amt: float = randf()
	print("headlight energy", str(rand_amt))
	headLights.energy = rand_amt
	timer.start(rand_amt)
	pass # Replace with function body.

# handle player outside light / health going down
func _on_player_character_health_changed(health: float) -> void:
	#radiusLight.energy = remap(health, 0, 100, 0, 1)
	const max_light_scale = 0.9
	
	var light_mapped = pow(health/100, 2)
	print(health, " ", light_mapped)
	#radiusLight.texture_scale = clamp(remap(health,0,100,0, max_light_scale), 0, 1)
	radiusLight.texture_scale = clamp(light_mapped, 0, 1)
	
	headLights.enabled = (health >= 100)
	
	pass # Replace with function body.
