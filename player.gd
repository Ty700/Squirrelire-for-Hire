extends CharacterBody2D

@export var speed = 300.0
@export var hp = 100.0

var shoot_cooldown = 0.5

var bullet_scene = preload("res://bullet.tscn")

func _physics_process(delta: float) -> void:
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

	velocity = input_dir * speed 
	#print("Player velocity: ", velocity.length())
	move_and_slide()
	
	if shoot_cooldown > 0.0:
		shoot_cooldown -= delta
		
	if shoot_cooldown <= 0.0:
		shoot()

func shoot():
	var nearest_enemy = find_nearest_enemy()
	
	if nearest_enemy:
		var bullet = bullet_scene.instantiate()
		var direction = (nearest_enemy.global_position - global_position).normalized()
		bullet.direction = direction
		bullet.global_position = global_position
		get_parent().add_child(bullet)
		
		#print("Bullet created at: ", bullet.global_position)  
		
		shoot_cooldown = 0.5
	
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
	hp -= damage_to_take
	#print("Player took damage! HP: ", hp)
		
	if(hp <= 0.0):
			death()
			
func death() -> void:
	queue_free()
	
	
