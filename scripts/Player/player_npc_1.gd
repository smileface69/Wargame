extends KinematicBody2D

var death = load("res://objects/other/death_ob.tscn")

var enemy_dict = {}  # Словарь для хранения врагов
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
	update_hp()
	if hp > max_hp:
		hp = max_hp
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

	if enemy_dict.size() == 0:
		condition = 1
	if enemy_dict.size() != 0:
		condition = 2


	if condition == 2:
		$AnimatedSprite.play("Attack") 
	
	if hp <= 0:
		condition = 3
		$player/CollisionShape2D.disabled = true
		$CollisionShape2D.disabled = true

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
	if "enemy" in body.name:
		if "enemy" in body.name:
			enemy_dict[body.name] = body



func _on_player_body_exited(body):
	if "enemy" in body.name:
		if enemy_dict.has(body.name):
			enemy_dict.erase(body.name)



func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attack" && enemy_dict.size() != 0:
		if enemy_dict.size() > 0:
			var first_key = enemy_dict.keys()[0]  # Получаем первый ключ
			var enemy = enemy_dict[first_key]
			enemy.hp -= 10
			if enemy.hp <= 0:
					enemy.kill()


