extends Area2D

@export var speed = 300.0
@export var damage = 100.0
var direction = Vector2.RIGHT

func _ready():
	body_entered.connect(_on_body_entered)
	
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	
	var player = get_tree().get_first_node_in_group("player")	
	
	if player and global_position.distance_to(player.global_position) > 1000:
		queue_free()

func _on_body_entered(body):
	#print("Bullet hit: ", body.name)  # Debug line
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
