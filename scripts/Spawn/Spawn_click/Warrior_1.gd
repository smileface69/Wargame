extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _physics_process(_delta):
	position = get_global_mouse_position()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed(): 
				pass
			else:
				
				MainScript.warrior_pick = 0 
				queue_free()


func _on_Click_era_1_1_area_entered(area):
	if "Line_1" in area.name:
		MainScript.line_pick = 1
	if "Line_2" in area.name:
		MainScript.line_pick = 2
	if "Line_3" in area.name:
		MainScript.line_pick = 3



func _on_Click_era_1_1_area_exited(area):
	if "Line_1" in area.name:
		MainScript.line_pick = 0
	if "Line_2" in area.name:
		MainScript.line_pick = 0
	if "Line_3" in area.name:
		MainScript.line_pick = 0
