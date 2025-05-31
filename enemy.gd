class_name BaseEnemy
extends CharacterBody2D

var enemy_options: 	Dictionary
var player:			CharacterBody2D

func init_base_enemy() -> void:
	enemy_options = {
		"hp": 			25,
		"speed": 		100,
		"dmg_cooldown": 0.5, # can hurt player every 0.5s
	}

func death() -> void:
	queue_free()
	
func _ready():
	player = get_tree().get_first_node_in_group("player")
	init_base_enemy()
	
func _physics_process(delta):
	handle_movement()
	handle_damage_countdown(delta)

func handle_movement():
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		var direction = (player.global_position - global_position).normalized()
		
		if distance_to_player >= 40:
			velocity = direction * enemy_options["speed"]
			move_and_slide()
		
		if(distance_to_player <= 35 && enemy_options["dmg_cooldown"] <= 0.0):
			var dmg_to_take = randi_range(5, 15)
			player.take_damage(dmg_to_take)
			enemy_options["dmg_cooldown"] = 0.5

func handle_damage_countdown(delta: float):
	if enemy_options["dmg_cooldown"] > 0.0:
		enemy_options["dmg_cooldown"] -= delta
	
func take_damage(damage_to_take: float) -> void:
	enemy_options["hp"] -= damage_to_take
	
	if(enemy_options["hp"] <= 0.0):
			death()
			
