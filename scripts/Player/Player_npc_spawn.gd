extends Node2D


var playernpcscene_1 = load("res://objects/player_npc/player_npc_era_1_1.tscn")
var playernpcscene_2 = load("res://objects/player_npc/player_npc_era_1_2.tscn")
var playernpcscene_3 = load("res://objects/player_npc/player_npc_era_1_3.tscn")
var playernpcscene_4 = load("res://objects/player_npc/player_npc_era_1_4.tscn")
var y_position = [0, 5, 10, 15]

var click_1 = load("res://objects/Click_ob/Click_era_1_1.tscn")
var click_2 = load("res://objects/Click_ob/Click_era_1_2.tscn")
var click_3 = load("res://objects/Click_ob/Click_era_1_3.tscn")
var click_4 = load("res://objects/Click_ob/Click_era_1_4.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var rand = RandomNumberGenerator.new()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass






func _on_Npc_1_pressed():
	if MainScript.warrior_pick == 0:
		var _screen_size = get_viewport().get_visible_rect().size
		var scene_click = click_1.instance()
		get_parent().add_child(scene_click)
		MainScript.warrior_pick = 1



func _on_Npc_2_pressed():
	if MainScript.warrior_pick == 0:
		var _screen_size = get_viewport().get_visible_rect().size
		var scene_click = click_2.instance()
		get_parent().add_child(scene_click)
		MainScript.warrior_pick = 2


func _on_Npc_3_pressed():
	if MainScript.warrior_pick == 0:
		var _screen_size = get_viewport().get_visible_rect().size
		var scene_click = click_3.instance()
		get_parent().add_child(scene_click)
		MainScript.warrior_pick = 3


func _on_Npc_4_pressed():
	if MainScript.warrior_pick == 0:
		var _screen_size = get_viewport().get_visible_rect().size
		var scene_click = click_4.instance()
		get_parent().add_child(scene_click)
		MainScript.warrior_pick = 4
