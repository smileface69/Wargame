extends KinematicBody2D

onready var animated_sprite = $AnimatedSprite

var death = load("res://objects/other/death_ob.tscn")
var stone = load("res://objects/other/stone_ob.tscn")

var object_in = 0

var enemy_dict = {}  # Словарь для хранения врагов

var reload = false

var rand = RandomNumberGenerator.new()
var velocity = Vector2()
var enemy
var id_enemy #здесь храним ид врага 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var id = 0 #у каждого нпс должен быть свой ид от 1 до млн
var speed = 20
var speed_y = 4
var condition = 1 
var hp = 100
var max_hp = 100

var rand_y_position = [0, 10, -10]
var y_position_move #позиция на которую встанет персонаж


# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.max_value = max_hp
	$HealthBar.visible = false
	animated_sprite.connect("frame_changed", self, "_on_AnimatedSprite_frame_changed")
	rand.randomize()
	id = rand.randi_range(1, 1000000)
	y_position_move = rand_y_position[randi() % rand_y_position.size()]
	if y_position_move == -10:
		z_index = 0
	if y_position_move == 0:
		z_index = 1

	if y_position_move == 10:
		z_index = 2

func _physics_process(_delta):
	if hp < max_hp:
		$HealthBar.visible = true
	if hp > max_hp:
		hp = max_hp
	update_hp()
	if condition == 1:
		if y_position_move == 10:
			if position.y < y_position_move:
				velocity.y = speed_y
			if position.y >= y_position_move:
				velocity.y = 0
		
		if y_position_move == -10:
			if position.y > y_position_move:
				velocity.y = -speed_y
			if position.y <= y_position_move:
				velocity.y = 0
		
		
		velocity.x = speed
		velocity = move_and_slide(velocity)
		$AnimatedSprite.play("Walk")
	if condition == 2:
		$AnimatedSprite.play("Stand") 
	
	if hp <= 0:
		condition = 4
		$player/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true
	
	if enemy_dict.size() == 0:
		condition = 1
	if enemy_dict.size() != 0 && reload == false:
		condition = 3
		$AnimatedSprite.play("Attack")

func update_hp():
	$HealthBar.value = hp
	if hp > max_hp:
		hp = max_hp


func kill():
	var _screen_size = get_viewport().get_visible_rect().size
	var deathscene = death.instance()
	deathscene.position.y = position.y
	deathscene.position.x = position.x
	get_parent().add_child(deathscene)
	queue_free()

func heal():
	$AnimatedHeal.frame = 0
	$AnimatedHeal.play("Heal")
	hp += max_hp*0.15

func _on_player_body_entered(body):
#	if "enemy" in body.name && condition == 1:
#		condition = 2
#		$Timer_attack.start()
	if "enemy" in body.name:
		enemy_dict[body.name] = body


func _on_player_body_exited(body):
#	if "enemy" in body.name && condition >= 2:
#		if enemy_dict.size() == 0:
#			condition = 1
#			$Timer_attack.stop()
#			$player/CollisionShape2D.disabled = true
#			$Timer_reload.start()
	if "enemy" in body.name:
		if enemy_dict.has(body.name):
			enemy_dict.erase(body.name)

#func _on_Timer_attack_timeout():
#	condition = 3
#	$AnimatedSprite.play("Attack")
#	var _screen_size = get_viewport().get_visible_rect().size
#	var stonescene = stone.instance()
#	stonescene.position.y = position.y + 4
#	stonescene.position.x = position.x + 24
#	get_parent().add_child(stonescene)


func _on_Timer_reload_timeout():
	$Timer_reload.stop()
	reload = false



func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attack":
		$AnimatedSprite.play("Stand")
		reload = true
		$Timer_reload.start()


func _on_AnimatedSprite_frame_changed():
	if animated_sprite.frame == 4 && $AnimatedSprite.animation == "Attack":
		var _screen_size = get_viewport().get_visible_rect().size
		var stonescene = stone.instance()
		stonescene.position.y = position.y + 4
		stonescene.position.x = position.x + 6
		get_parent().add_child(stonescene)
