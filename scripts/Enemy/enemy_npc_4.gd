extends KinematicBody2D

var death = load("res://objects/other/death_ob.tscn")
var heal = load("res://objects/other/heal_ob_enemy.tscn")
var heal_friend = true
var reload_heal = false


var enemy_dict = {}  # Словарь для хранения врагов
var friend_dict = {}
var rand = RandomNumberGenerator.new()
var velocity = Vector2()
var enemy
var id_enemy #здесь храним ид врага 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var id = 0 #у каждого нпс должен быть свой ид от 1 до млн
var speed = - 20
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
	print(friend_dict)
	if hp < max_hp:
		$HealthBar.visible = true
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

	if friend_dict.size() == 0 && enemy_dict.size() == 0:
		heal_friend = false
		condition = 1

	if friend_dict.size() != 0 && enemy_dict.size() == 0 && reload_heal == false:
		condition = 4
		heal_friend = true
		
	if enemy_dict.size() != 0:
		condition = 2
		heal_friend = false

	
	
	if condition == 2:
		$AnimatedSprite.play("Attack") 
	if condition == 3:
		$AnimatedSprite.play("Stand") 
	if condition == 4:
		$AnimatedSprite.play("Heal")

	
	
	if hp <= 0:
		condition = 6
		$enemy/CollisionShape2D.disabled = true
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

func _on_player_body_entered(body):
	if "player" in body.name:
		if "player" in body.name:
			enemy_dict[body.name] = body




func _on_player_body_exited(body):
	if "player" in body.name:
		if enemy_dict.has(body.name):
			enemy_dict.erase(body.name)





func _on_Timer_attack_timeout():
	if friend_dict.size() == 0:
		condition = 2
	$Timer_attack.stop()




func _on_Timer_reload_timeout():
	$enemy/CollisionShape2D.disabled = false
	$Timer_reload.stop()



func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attack" && enemy_dict.size() != 0:
		if enemy_dict.size() > 0:
			var first_key = enemy_dict.keys()[0]  # Получаем первый ключ
			var enemy = enemy_dict[first_key]
			enemy.hp -= 5
			condition = 3
			$Timer_attack.start()
			if enemy.hp <= 0:
					enemy.kill()
	if $AnimatedSprite.animation == "Heal" && friend_dict.size() != 0:
		var _screen_size = get_viewport().get_visible_rect().size
		var healscene = heal.instance()
		healscene.position.y = position.y + 4
		healscene.position.x = position.x - 6
		get_parent().add_child(healscene)
		reload_heal = true
		condition = 3
		$Timer_heal.start()

func _on_area_health_body_entered(body):
	if "enemy_ally" in body.name:
		friend_dict[body.name] = body


func _on_area_health_body_exited(body):
	if "enemy_ally" in body.name:
		if friend_dict.has(body.name):
			friend_dict.erase(body.name)




func _on_Timer_heal_timeout():
	if friend_dict.size() != 0 && heal_friend == true:
		condition = 4
	$Timer_heal.stop()
	reload_heal = false
