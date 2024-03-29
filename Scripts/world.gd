extends Node

export var score = 1000
export var lives = 2
export var tempLives = 0
export var bricks = 66
signal lifeDecrease

var new_ball = preload("res://Scenes/Ball.tscn")

onready var BallNode = get_node("/root/World/Ball")
onready var PaddleNode = get_node("/root/World/Paddle")

func _ready():
 connect("lifeDecrease", PaddleNode, "lifeSub")

func increase_score(s):
 score += int(s)
 bricks -= 1
 find_node("Score").update_score()
 if bricks <= 0:
   get_tree().change_scene("res://Scenes/LevelThree.tscn")
 
func decrease_lives():
 if tempLives == 0:
   lives -= 1
   find_node("Lives").update_lives()
   emit_signal("lifeDecrease")
   if lives <= 0:
     get_tree().change_scene("res://Scenes/End.tscn")
 else:
    tempLives -= 1

func duplicateBall(vec):
  var ball = new_ball.instance()
  ball.position = vec
  ball.name = "Ball1"
  ball.linear_velocity = Vector2(200, -200)
  add_child(ball)

  var ball2 = new_ball.instance()
  ball2.position = vec
  ball2.linear_velocity = Vector2(-200, -200)
  ball2.name = "Ball2"
  add_child(ball2)
  tempLives += 2