extends Node2D


var playernpcscene_1 = load("res://objects/player_npc/player_npc_era_1_1.tscn")
var playernpcscene_2 = load("res://objects/player_npc/player_npc_era_1_2.tscn")
var playernpcscene_3 = load("res://objects/player_npc/player_npc_era_1_3.tscn")
var playernpcscene_4 = load("res://objects/player_npc/player_npc_era_1_4.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed(): 
				pass
			else:
				if MainScript.line_pick == 2 && MainScript.warrior_pick == 1:
					var _screen_size = get_viewport().get_visible_rect().size
					var playernpc = playernpcscene_1.instance()
					add_child(playernpc)
				if MainScript.line_pick == 2 && MainScript.warrior_pick == 2:
					var _screen_size = get_viewport().get_visible_rect().size
					var playernpc = playernpcscene_2.instance()
					add_child(playernpc)
				if MainScript.line_pick == 2 && MainScript.warrior_pick == 3:
					var _screen_size = get_viewport().get_visible_rect().size
					var playernpc = playernpcscene_3.instance()
					add_child(playernpc)
				if MainScript.line_pick == 2 && MainScript.warrior_pick == 4:
					var _screen_size = get_viewport().get_visible_rect().size
					var playernpc = playernpcscene_4.instance()
					add_child(playernpc)
