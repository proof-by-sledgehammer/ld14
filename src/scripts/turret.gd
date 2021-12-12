class_name Turret
extends Node2D

enum Turret {
	TURRET1,
	TURRET2,
	TURRET3
}

var normalShotPrefab = preload("res://prefabs/normal shot.tscn")
var quickShotPrefab  = preload("res://prefabs/quick shot.tscn")
var heavyShotPrefab  = preload("res://prefabs/heavy shot.tscn")

export(Turret) var turret
export(Vector2) var shootDirection
export(NodePath) var wallOfDoom

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
	match turret:
		Turret.TURRET1:
			$Audio1.play()
		Turret.TURRET2:
			$Audio2.play()
		Turret.TURRET3:
			$Audio3.play()

func process_shooting(delta):
	if cooldown <= 0.0:
		if shootsLeft >- 0:
			spawn_bullet()
			shootsLeft -= 1
		cooldown = getCooldown()
	else:
		cooldown -= delta

func animation_suffix():
	match Direction.from_vec(shootDirection):
		Direction.Direction.EAST:
			return "_e"
		Direction.Direction.WEST:
			return "_w"
		_:
			return ""

func start_animation():
	match turret:
		Turret.TURRET1:
			get_node("Skin").animation = "tower1" + animation_suffix()
		Turret.TURRET2:
			get_node("Skin").animation = "tower2" + animation_suffix()
		Turret.TURRET3:
			get_node("Skin").animation = "tower3" + animation_suffix()

func explode():
	shootsLeft = 0
	$Skin.animation = "explosion"
	$Skin.play()
	$Hitbox.disabled = true
	$Explosion.play()

func _ready():
	shootsLeft = get_initial_shoots_left()
	start_animation()

func _process(delta):
	process_shooting(delta)
	
func _on_Skin_animation_finished():
	queue_free()
