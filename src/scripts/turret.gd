class_name Turret
extends Node2D

enum Turret {
	TURRET1,
	TURRET2,
	TURRET3
}

var normalShotPrefab = preload("res://prefabs/normal shot.tscn")
var quickShotPrefab = preload("res://prefabs/quick shot.tscn")
var heavyShotPrefab = preload("res://prefabs/heavy shot.tscn")

export(Turret) var turret
export(Vector2) var shootDirection

var cooldown = 0
var shootsLeft = 0

func getCooldown():
	match turret:
		Turret.TURRET1:
			return 1.0
		Turret.TURRET2:
			return 0.06
		Turret.TURRET3:
			return 3.0
			
func get_initial_shoots_left():
	match turret:
		Turret.TURRET1:
			return 10
		Turret.TURRET2:
			return 100
		Turret.TURRET3:
			return 5

func get_bullet_prefab():
	match turret:
		Turret.TURRET1:
			return normalShotPrefab
		Turret.TURRET2:
			return quickShotPrefab
		Turret.TURRET3:
			return heavyShotPrefab

func spawn_bullet():
	var shot = get_bullet_prefab().instance()
	shot.position = Vector2(0,0)
	shot.linear_velocity = shootDirection * 1000
	add_child(shot)

func process_shooting(delta):
	if cooldown <= 0.0:
		if shootsLeft >- 0:
			spawn_bullet()
			shootsLeft -= 1
		cooldown = getCooldown()
	else:
		cooldown -= delta

func _ready():
	shootsLeft = get_initial_shoots_left()

func _process(delta):
	process_shooting(delta)
