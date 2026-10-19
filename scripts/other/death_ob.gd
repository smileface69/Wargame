extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	$AnimatedSprite.play("Death")
	


func _on_Timer_timeout():
	queue_free()
