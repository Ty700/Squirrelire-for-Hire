class_name BaseProjectile
extends Area2D

var projectile_stats: Dictionary
var direction = Vector2.RIGHT

func _ready():
	init_projectile()
	body_entered.connect(_on_body_entered)

func init_projectile():
	# Override in subclasses
	projectile_stats = {
		"speed": 300.0,
		"damage": 10.0,
		"max_distance": 1000.0
	}

func _physics_process(delta: float) -> void:
	move_projectile(delta)
	check_cleanup()

func move_projectile(delta: float):
	global_position += direction * projectile_stats["speed"] * delta

func check_cleanup():
	var player = get_tree().get_first_node_in_group("player")	
	
	if player and global_position.distance_to(player.global_position) > projectile_stats["max_distance"]:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("player"):
		return 
	else:
		if body.has_method("take_damage"):
			body.take_damage(projectile_stats["damage"])
			queue_free()
	
