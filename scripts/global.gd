extends Node

signal fuel_changed

@export var van_fuel: float = 25:
	set(value):
		van_fuel = clamp(value,0,100)
		fuel_changed.emit(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if van_fuel <= 0:
		# make light shrink
		pass
	pass
