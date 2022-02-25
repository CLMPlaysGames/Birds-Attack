extends Node2D

var score

func _ready():
	randomize()
	get_node("Player").hide()
	get_node("BackgroundMusic").play()

func _on_EnemyTImer_timeout():
	var newEnemyPath = load("res://Enemy.tscn")
	var newEnemy = newEnemyPath.instance()
	add_child(newEnemy)
	
	get_node("EnemyPath/EnemySpawn").set_offset(randi())
	newEnemy.position = get_node("EnemyPath/EnemySpawn").position
	
	var direction = get_node("EnemyPath/EnemySpawn").rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	newEnemy.rotation = direction
	
	newEnemy.linear_velocity = Vector2(rand_range(newEnemy.minSpeed, newEnemy.maxSpeed), 0)
	newEnemy.linear_velocity = newEnemy.linear_velocity.rotated(direction)


func _on_ScoreTimer_timeout():
	score += 1
	get_node("UI").updateScore(score)

func _on_StartTimer_timeout():
	get_node("ScoreTimer").start()
	get_node("EnemyTimer").start()


func _on_Player_hit():
	get_node("EnemyTimer").stop()
	get_node("ScoreTimer").stop()
	get_node("UI").showGameOver()
	get_node("BackgroundMusic").stop()
	get_node("GameOverMusic").play()

func _on_UI_startGame():
	score = 0
	get_node("Player").position = get_viewport_rect().size / 2
	get_node("Player").show()
	get_node("Player/CollisionShape2D").set_deferred("disabled", false)
	get_node("StartTimer").start()
	get_node("UI").updateScore(score)
	get_node("UI").showMessage("Incoming Birds!")
	if (!get_node("BackgroundMusic").playing):
		get_node("BackgroundMusic").play()
		get_node("GameOverMusic").stop()