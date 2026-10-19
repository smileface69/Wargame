extends KinematicBody2D

var enemy_dict = {}  # Словарь для хранения врагов


var speed = 300
var velocity = Vector2()
var condition = 1

func _ready():
	pass # Replace with function body.



func _physics_process(_delta):
	velocity.x = speed
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	if "player_ally" in body.name:
		body.heal()
		queue_free()


