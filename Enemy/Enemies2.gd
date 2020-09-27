extends KinematicBody2D

onready var HUD = get_node("/root/Game/HUD")

export var speed = Vector2(0,3)
export var health = 100
export var points = 10
export var damage = 50

onready var Explosion = load("res://Explosion/Explosion.tscn")


func _physics_process(delta):
	position += speed

	if position.y > get_viewport().size.y + 100:
		queue_free()

func die():
	HUD.update_score(points)
	var explosion = Explosion.instance()
	explosion.position = position
	get_node("/root/Game/Explosions").add_child(explosion)
	explosion.get_node("Animation").play()
	queue_free()


onready var Enemy = load("res://Enemy/Enemy2.tscn")
export var prob = 0.8

onready var width = get_viewport().size.x

func _on_Timer_timeout():
	if randf() < prob:
		var enemy = Enemy.instance()
		enemy.position.x = randi() % int(width)
		enemy.speed = Vector2(0, (randi() % 5)+1)
		add_child(enemy)
		
		
