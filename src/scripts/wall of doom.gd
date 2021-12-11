extends RigidBody2D

func _ready():
	apply_impulse(Vector2(0, 100), Vector2(10,0))
	apply_torque_impulse(100.0)
