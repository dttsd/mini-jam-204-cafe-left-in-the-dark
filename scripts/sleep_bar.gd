extends CanvasLayer

var sleeplvl:
	get:
		return Global.awakeness
	set(value):
		Global.awakeness = value
		

@export var sleepspeed: float = 0.2


@export var eye_states: Array[Texture2D]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProgressBar.value = sleeplvl

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	#sleeplvl = sleeplvl - sleepspeed
	#clamp(sleeplvl, 0, 100)
	$ProgressBar.value = sleeplvl
	#print(sleeplvl)
	if sleeplvl > 75:
		$MarginContainer/eye.texture = eye_states[0]
	elif sleeplvl > 50:
		$MarginContainer/eye.texture = eye_states[1]
	elif sleeplvl > 15:
		$MarginContainer/eye.texture = eye_states[2]
	elif sleeplvl > 0:
		$MarginContainer/eye.texture = eye_states[3]
	elif sleeplvl <= 0:
		$MarginContainer/eye.texture = eye_states[4]

const BAR_SPEED = 5
var current_bar_value = 100
