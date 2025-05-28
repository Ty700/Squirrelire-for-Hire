extends CharacterBody2D

@export var speed = 150.0
var player = null
var dmg_cooldown = 0.5 #secs 
var hp = 25.0

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):	
	if dmg_cooldown > 0.0:
		dmg_cooldown -= delta
	
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		var direction = (player.global_position - global_position).normalized()
		
		if distance_to_player >= 40:
			velocity = direction * speed
			move_and_slide()
		
		if(distance_to_player <= 35 && dmg_cooldown <= 0.0):
			var dmg_to_take = randi_range(5, 15)
			player.take_damage(dmg_to_take)
			dmg_cooldown = 0.5

func take_damage(damage_to_take: float) -> void:
	#print("Enemy took damage: ")
	hp -= damage_to_take
	
	if(hp <= 0.0):
			death()
			
func death() -> void:
	queue_free()
