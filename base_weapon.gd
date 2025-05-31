class_name BaseWeapon
extends Node2D

var weapon_stats: Dictionary
var current_cooldown: float = 0.0

func _ready():
	init_weapon()

func init_weapon():
	# Override in subclasses
	weapon_stats = {
		"cooldown": 0.5,
		"projectile_scene": null
	}

func can_shoot() -> bool:
	return current_cooldown <= 0.0

func try_shoot(target_pos: Vector2) -> bool:
	if can_shoot():
		shoot(target_pos)
		current_cooldown = weapon_stats["cooldown"]
		return true
	return false

func shoot(target_pos: Vector2):
	# Override in subclasses
	if weapon_stats["projectile_scene"]:
		var projectile = weapon_stats["projectile_scene"].instantiate()
		var direction = (target_pos - global_position).normalized()
		projectile.direction = direction
		
		# Use muzzle point if it exists, otherwise use weapon center
		if has_node("MuzzlePoint"):
			projectile.global_position = $MuzzlePoint.global_position
		else:
			projectile.global_position = global_position
			
		get_tree().current_scene.add_child(projectile)

func _physics_process(delta):
	if current_cooldown > 0.0:
		current_cooldown -= delta
