class_name SquirePlayer
extends BasePlayer

func setup_weapon():
	# Give the squire an acorn gun by default
	var acorn_gun_scene = preload("res://acorn_gun.tscn")
	weapon = acorn_gun_scene.instantiate()
	add_child(weapon)
