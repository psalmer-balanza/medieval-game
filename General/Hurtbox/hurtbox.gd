class_name Hurtbox extends Area2D

@export var damage: int = 1
signal Damaged(damage: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect( AreaEntered )
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func AreaEntered(a: Area2D) -> void:
	if a is Hitbox:
		a.take_damage(damage)
	pass
