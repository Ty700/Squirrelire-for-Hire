class_name AcornGun
extends BaseWeapon

func init_weapon():
	weapon_stats = {
		"cooldown": 0.5,
		"projectile_scene": preload("res://acorn_projectile.tscn")
	}
	
func shoot(target_pos: Vector2):
	var acorn = weapon_stats["projectile_scene"].instantiate()
	var direction = (target_pos - global_position).normalized()
	acorn.direction = direction
	acorn.global_position = $MuzzlePoint.global_position  # Use muzzle instead of gun center
	get_tree().current_scene.add_child(acorn)
