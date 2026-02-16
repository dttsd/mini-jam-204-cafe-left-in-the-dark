extends StaticBody2D

@export var max_speed:float = 30

@export var on_menu:bool = false

@export var speed: float = 20:
	get:
		return Global.van_speed
	set(value):
		Global.van_speed = value

@onready var timer := $Timer
@onready var radiusLight := $RadiusLight
@onready var headLights := $HeadLights
@onready var engine_sound: AudioStreamPlayer2D = self.get_children().filter(func(el): return el is AudioStreamPlayer2D)[0]

@export var van_fuel_consumption:float = 2.5

@onready var interactArea: Area2D = $InteractArea
@onready var smoke_emitter:GPUParticles2D = self.find_child("SmokeParticles") 

@export var fuel_curve_speed: Curve
var engine_running = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.constant_linear_velocity = Vector2.RIGHT * speed
	#interactArea.area_entered.connect(_on_interact_area_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2.RIGHT * speed * delta
	decrease_van_stats(delta)
	pass
	
func decrease_van_stats(delta: float):
	if on_menu:
		return
	
	Global.van_fuel -= van_fuel_consumption * delta
	speed = fuel_curve_speed.sample(Global.van_fuel) * max_speed
	
	# turn engine sound off if below set speed
	if speed < 1:
		if engine_running:
			#engine_sound.playing = false
			# tween
			var tween = get_tree().create_tween()
			tween.tween_property(engine_sound, "pitch_scale", 0, 1)
			#tween.tween_callback(func(): item.queue_free())
			$AnimationPlayer.pause()

			smoke_emitter.emitting = false
			engine_running = false
	else:
		if not engine_running:
			var tween = get_tree().create_tween()
			tween.tween_property(engine_sound, "pitch_scale", 1, 1)
			#tween.tween_callback(func(): item.queue_free())
			$AnimationPlayer.play()
			smoke_emitter.emitting = true
			engine_running = true
			
	pass
	

#func _on_interact_area_entered():
	##print("VAN ENTER: ", area)
	#pass

func _on_timer_timeout() -> void:
	var rand_amt: float = randf()
	#print("headlight energy", str(rand_amt))
	headLights.energy = rand_amt
	timer.start(rand_amt)
	pass # Replace with function body.

# handle player outside light / health going down
func _on_player_character_health_changed(health: float) -> void:
	#radiusLight.energy = remap(health, 0, 100, 0, 1)
	const max_light_scale = 0.9
	
	var light_mapped = pow(health/100, 2)
	#print(health, " ", light_mapped)
	#radiusLight.texture_scale = clamp(remap(health,0,100,0, max_light_scale), 0, 1)
	radiusLight.texture_scale = clamp(light_mapped, 0.2, 1)
	
	headLights.enabled = (health >= 100)
	
	pass # Replace with function body.
