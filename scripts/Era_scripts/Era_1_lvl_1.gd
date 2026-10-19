extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _physics_process(_delta):
	if MainScript.warrior_pick == 1:
		$CanvasLayer/UI/HBoxContainer/Npc_1.modulate = Color("9cffe300") 
	else:
		$CanvasLayer/UI/HBoxContainer/Npc_1.modulate = Color("ffffff") 

	if MainScript.warrior_pick == 2:
		$CanvasLayer/UI/HBoxContainer/Npc_2.modulate = Color("9cffe300") 
	else:
		$CanvasLayer/UI/HBoxContainer/Npc_2.modulate = Color("ffffff")

	if MainScript.warrior_pick == 3:
		$CanvasLayer/UI/HBoxContainer/Npc_3.modulate = Color("9cffe300") 
	else:
		$CanvasLayer/UI/HBoxContainer/Npc_3.modulate = Color("ffffff") \

	if MainScript.warrior_pick == 4:
		$CanvasLayer/UI/HBoxContainer/Npc_4.modulate = Color("9cffe300") 
	else:
		$CanvasLayer/UI/HBoxContainer/Npc_4.modulate = Color("ffffff") 
