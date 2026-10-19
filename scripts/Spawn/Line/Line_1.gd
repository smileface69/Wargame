extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	self.modulate = Color("#56d333") 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(_delta):
	if MainScript.warrior_pick != 0 && MainScript.line_pick != 1:
		self.modulate = Color("fffb00") 
	if MainScript.warrior_pick == 0:
		self.modulate = Color("ffffff") 
	if MainScript.warrior_pick != 0 && MainScript.line_pick == 1:
		self.modulate = Color("ffffff") 
