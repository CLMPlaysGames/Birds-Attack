extends RigidBody2D

var minSpeed
var maxSpeed
var enemyTypes

func _ready():
	minSpeed = 150
	maxSpeed = 300
	enemyTypes = randi() % 3
	
	if (enemyTypes == 0):
		get_node("AnimatedSprite").animation = "enemy1"
	elif (enemyTypes == 1):
		get_node("AnimatedSprite").animation = "enemy2"
	elif (enemyTypes == 2):
		get_node("AnimatedSprite").animation = "enemy3"
	
	get_node("AnimatedSprite").play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
