extends KinematicBody2D

var new_ball = preload("res://Scenes/Ball.tscn")
var livesHelper = 1

func _ready():
 set_process_input(true)

func _physics_process(delta):
 var mouse_x = get_viewport().get_mouse_position().x
 position = Vector2(mouse_x, position.y)

func lifeHelper():
   livesHelper += 2

func lifeSub():
   livesHelper -= 1

func _input(event):
 if event is InputEventMouseButton and event.pressed:
  if livesHelper < 1:
   var ball = new_ball.instance()
   ball.position = position - Vector2(0, 32)
   ball.name = "Ball"
   ball.linear_velocity = Vector2(200, -200)
   get_parent().add_child(ball)
   livesHelper = 1