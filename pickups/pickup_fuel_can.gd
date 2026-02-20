class_name item_fuel_can extends ItemComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	super(_delta)
	pass

func use():
	Global.van_fuel += 30
