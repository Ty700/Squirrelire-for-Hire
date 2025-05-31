class_name BasePlayer
extends CharacterBody2D

var player_options: Dictionary
var weapon: BaseWeapon

func _ready() -> void:
	init_player()
	setup_weapon()

func init_player() -> void:
	# Override in subclasses for different stats
	player_options = {
		"speed": 300.0,
		"hp": 100.0,
		"max_hp": 100.0
	}

func setup_weapon():
	# Override in subclasses for different starting weapons
	pass
	
func _physics_process(delta: float) -> void:
	handle_movement()
	handle_shooting(delta)
	
func handle_movement() -> void:
	var input_dir = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.y += 1
	if Input.is_action_pressed("ui_up"):
		input_dir.y -= 1
	
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()

	velocity = input_dir * player_options["speed"] 
	move_and_slide()

func handle_shooting(delta: float):
	if weapon:
		var nearest_enemy = find_nearest_enemy()
		if nearest_enemy:
			weapon.try_shoot(nearest_enemy.global_position)
	
func find_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var nearest = null
	var shortest_distance = 999999
	
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			nearest = enemy
	
	return nearest

func take_damage(damage_to_take: float) -> void:
	player_options["hp"] -= damage_to_take
		
	if player_options["hp"] <= 0.0:
		death()

func death() -> void:
	queue_free()

# Weapon management functions
func change_weapon(new_weapon: BaseWeapon):
	if weapon:
		weapon.queue_free()
	weapon = new_weapon
	add_child(weapon)
