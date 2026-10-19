extends KinematicBody2D

var enemy_dict = {}  # Словарь для хранения врагов


var speed = 150
var velocity = Vector2()
var condition = 1

func _ready():
	pass # Replace with function body.



func _physics_process(_delta):
	velocity.x = speed
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
		if "enemy" in body.name && enemy_dict.size() > 0:
			var first_key = enemy_dict.keys()[0]  # Получаем первый ключ
			var enemy = enemy_dict[first_key]
			enemy.hp -= 100
			queue_free()
			if enemy.hp <= 0:
					enemy.kill()


func _on_Area2D_search_body_entered(body):
	if "enemy" in body.name:
		enemy_dict[body.name] = body



func _on_Area2D_search_body_exited(body):
	if "enemy" in body.name:
		if enemy_dict.has(body.name):
			enemy_dict.erase(body.name)
