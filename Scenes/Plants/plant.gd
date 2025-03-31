class_name Plant extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(take_damage)
	pass # Replace with function body.


# Hitbox emits a signal Damaged, we react to it here
func take_damage(damage: int) -> void:
	queue_free()
	pass
