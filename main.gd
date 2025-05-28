extends Node2D

var enemy_scene = preload("res://enemy.tscn")
var spawn_cooldown = 5.0
var spawn_count = 20

func _ready():
	spawn_enemies()

func _physics_process(delta):
	if spawn_cooldown >= 0.0:
		spawn_cooldown -= delta 
		
	if spawn_cooldown <= 0.0:
		spawn_enemies()
		spawn_cooldown = 2.0

func spawn_enemies():
	for i in range(spawn_count):
		var enemy = enemy_scene.instantiate()
		
		var spawn_pos = get_random_spawn_position()
		enemy.global_position = spawn_pos

		add_child(enemy)

func get_random_spawn_position():
	var screen_size = get_viewport().get_visible_rect().size
	var margin = 50
	
	var side = randi() % 4
	
	match side:
		0: # Top
			return Vector2(randf() * screen_size.x, -margin)
		1: # Right
			return Vector2(screen_size.x + margin, randf() * screen_size.y)
		2: # Bottom
			return Vector2(randf() * screen_size.x, screen_size.y + margin)
		3: # Left
			return Vector2(-margin, randf() * screen_size.y)
	
	return Vector2.ZERO
